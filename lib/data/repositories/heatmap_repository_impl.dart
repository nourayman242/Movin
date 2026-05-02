import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  static const _baseUrl = 'https://movin-backend-production.up.railway.app';
  static const _filterEndpoint = '$_baseUrl/api/seller/properties/filter';

  
  static final _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));

  @override
  Future<List<AreaScore>> getAreaScores() async {
    final futures = _kAreaCenters.entries.map((entry) async {
      final areaName = entry.key;
      final center = entry.value;

      try {
        final response = await _dio.get(
          _filterEndpoint,
          queryParameters: {
            'location': areaName.toLowerCase(),
            'limit': 1,
            'page': 1,
          },
        );

        final data = response.data as Map<String, dynamic>;
        final count = (data['locationTotalCount'] as num?)?.toInt()
            ?? (data['total'] as num?)?.toInt()
            ?? 0;

        return AreaScoreModel(
          name: areaName,
          center: center,
          listingCount: count,
        );
      } catch (_) {
        // One area failing should never block the whole map
        return AreaScoreModel(name: areaName, center: center, listingCount: 0);
      }
    });

    final results = await Future.wait(futures);
    results.sort((a, b) => b.listingCount.compareTo(a.listingCount));
    return results;
  }
}