import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/data/models/property_model.dart';
import '../../domain/entities/area_score.dart';
import '../../domain/repositories/heatmap_repository.dart';
import '../models/area_score_model.dart';


final _kAreaCenters = <String, LatLng>{
  'New Cairo':      const LatLng(30.0285, 31.4913),
  'Rehab City':     const LatLng(30.0571, 31.4935),
  'Madinaty':       const LatLng(30.1025, 31.6038),
  'Nasr City':      const LatLng(30.0519, 31.3656),
  'Shorouk City':   const LatLng(30.1468, 31.6091),
  'Heliopolis':     const LatLng(30.0870, 31.3220),
  'Downtown Cairo': const LatLng(30.0444, 31.2357),
  'Giza':           const LatLng(30.0131, 31.2089),
};
final _kAreaBackendNames = <String, String>{
  'New Cairo':      'New Cairo',
  'Rehab City':     'rehab',        
  'Madinaty':       'Madinaty',
  'Nasr City':      'Nasr City',
  'Shorouk City':   'Shorouk City',
  'Heliopolis':     'Heliopolis',
  'Downtown Cairo': 'Downtown Cairo',
  'Giza':           'Giza',
};

String _canonicalArea(String name) {
  final lower = name.trim().toLowerCase();
  if (lower.contains('rehab'))     return 'rehab';
  if (lower.contains('new cairo')) return 'New Cairo';
  if (lower.contains('madinaty'))  return 'Madinaty';
  if (lower.contains('nasr'))      return 'Nasr City';
  if (lower.contains('shorouk'))   return 'Shorouk City';
  if (lower.contains('heliopo'))   return 'Heliopolis';
  if (lower.contains('downtown'))  return 'Downtown Cairo';
  if (lower.contains('giza'))      return 'Giza';
  return name.trim();
}

class HeatmapRepositoryImpl implements HeatmapRepository {
  static const _baseUrl = 'https://movin-backend-production-e804.up.railway.app';
  static const _filterEndpoint = '$_baseUrl/api/seller/properties/filter';

  static final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  /// Builds query params shared across every page request for a given area,
  /// merging the canonical area name with whatever filters the user applied.
  Map<String, dynamic> _buildParams({
 required String areaName,
    required int page,
    String? propertyType,
    String? bedrooms,
    String? bathrooms,
    bool? hasPool,
    double? minPrice,
    double? maxPrice,
  }) {
    final params = <String, dynamic>{
      'location': _kAreaBackendNames[areaName] ?? _canonicalArea(areaName),
      'limit': 50,
      'page': page,
    };

    if (propertyType != null && propertyType.isNotEmpty) {
      params['type'] = propertyType.toLowerCase();
    }
    if (bedrooms != null && bedrooms.isNotEmpty) {
      params['bedrooms'] = bedrooms.replaceAll('+', '');
    }
    if (bathrooms != null && bathrooms.isNotEmpty) {
      params['bathrooms'] = bathrooms.replaceAll('+', '');
    }
    if (hasPool != null) {
      params['pool'] = hasPool.toString();
    }
    if (minPrice != null && minPrice > 0) {
      params['minPrice'] = minPrice.toInt();
    }
    if (maxPrice != null && maxPrice < 10000000) {
      params['maxPrice'] = maxPrice.toInt();
    }

    return params;
  }

  @override
  Future<List<AreaScore>> getAreaScores({
    String? propertyType,
    String? bedrooms,
    String? bathrooms,
    bool? hasPool,
    double? minPrice,
    double? maxPrice,
  }) async {
    final token = await SharedHelper.getToken();

    final futures = _kAreaCenters.entries.map((entry) async {
      // entry.key is already canonical — _canonicalArea inside _buildParams
      // will still normalise it, but it's a no-op for canonical keys.
      final areaName = entry.key;
      final center = entry.value;

      try {
        // ── First page ──────────────────────────────────────────────────────
        final firstResponse = await _dio.get(
          _filterEndpoint,
          queryParameters: _buildParams(
            areaName: areaName,
            page: 1,
            propertyType: propertyType,
            bedrooms: bedrooms,
            bathrooms: bathrooms,
            hasPool: hasPool,
            minPrice: minPrice,
            maxPrice: maxPrice,
          ),
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        final data = firstResponse.data as Map<String, dynamic>;

        final totalPages = (data['totalPages'] as num?)?.toInt() ?? 1;

        final rawList = data['properties'] as List<dynamic>? ?? [];
        final listings = rawList
            .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>).toEntity())
            .toList();

        // ── Remaining pages (if any) ────────────────────────────────────────
        if (totalPages > 1) {
          final remainingFutures = List.generate(
            totalPages - 1,
            (i) async {
              final pageResponse = await _dio.get(
                _filterEndpoint,
                queryParameters: _buildParams(
                  areaName: areaName,
                  page: i + 2,
                  propertyType: propertyType,
                  bedrooms: bedrooms,
                  bathrooms: bathrooms,
                  hasPool: hasPool,
                  minPrice: minPrice,
                  maxPrice: maxPrice,
                ),
                options: Options(headers: {'Authorization': 'Bearer $token'}),
              );

              final pageData = pageResponse.data as Map<String, dynamic>;
              final pageList = pageData['properties'] as List<dynamic>? ?? [];
              return pageList
                  .map((e) => PropertyModel.fromJson(
                        e as Map<String, dynamic>,
                      ).toEntity())
                  .toList();
            },
          );

          final remainingResults = await Future.wait(remainingFutures);
          for (final page in remainingResults) {
            listings.addAll(page);
          }
        }

        print('Heatmap [$areaName]: fetched ${listings.length}');

        return AreaScoreModel(
          name: areaName,
          center: center,
          listingCount: listings.length,
          listings: listings,
        );
      } catch (e) {
        print('Heatmap fetch failed for $areaName: $e');
        return AreaScoreModel(
          name: areaName,
          center: center,
          listingCount: 0,
          listings: [],
        );
      }
    });

    final results = await Future.wait(futures);
    results.sort((a, b) => b.listingCount.compareTo(a.listingCount));
    return results;
  }
}