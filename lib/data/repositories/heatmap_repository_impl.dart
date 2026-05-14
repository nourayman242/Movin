import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/data/models/property_model.dart';
import 'package:movin/domain/entities/property_entity.dart';
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

class HeatmapRepositoryImpl implements HeatmapRepository {
  static const _baseUrl = 'https://movin-backend-production-e804.up.railway.app';
  static const _filterEndpoint = '$_baseUrl/api/seller/properties/filter';

  static final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  Future<List<PropertyEntity>> _fetchAllPages(
    String areaName,
    String token,
  ) async {
    final List<PropertyEntity> all = [];
    int page = 1;
    int totalPages = 1;

    do {
      final response = await _dio.get(
        _filterEndpoint,
        queryParameters: {
          'location': areaName,
          'limit': 50, 
          'page': page,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      final data = response.data as Map<String, dynamic>;

      
      totalPages = (data['totalPages'] as num?)?.toInt() ?? 1;

      final rawList = data['properties'] as List<dynamic>? ?? [];
      final listings = rawList
          .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>).toEntity())
          .toList();

      all.addAll(listings);
      page++;
    } while (page <= totalPages);

    return all;
  }

  @override
  Future<List<AreaScore>> getAreaScores() async {
    final token = await SharedHelper.getToken();

    final futures = _kAreaCenters.entries.map((entry) async {
      final areaName = entry.key;
      final center = entry.value;

      try {
        
        final response = await _dio.get(
          _filterEndpoint,
          queryParameters: {
            'location': areaName,
            'limit': 50, 
            'page': 1,
          },
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );

        final data = response.data as Map<String, dynamic>;

        final count = (data['locationTotalCount'] as num?)?.toInt()
            ?? (data['total'] as num?)?.toInt()
            ?? 0;

        final totalPages = (data['totalPages'] as num?)?.toInt() ?? 1;

        
        final rawList = data['properties'] as List<dynamic>? ?? [];
        List<PropertyEntity> listings = rawList
            .map((e) => PropertyModel.fromJson(e as Map<String, dynamic>).toEntity())
            .toList();

        
        if (totalPages > 1) {
          final remainingFutures = List.generate(
            totalPages - 1,
            (i) async {
              final pageResponse = await _dio.get(
                _filterEndpoint,
                queryParameters: {
                  'location': areaName,
                  'limit': 50, 
                  'page': i + 2,
                },
                options: Options(
                  headers: {'Authorization': 'Bearer $token'},
                ),
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

        print('Heatmap [$areaName]: $count total, fetched ${listings.length}');

        return AreaScoreModel(
          name: areaName,
          center: center,
          listingCount: count,
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