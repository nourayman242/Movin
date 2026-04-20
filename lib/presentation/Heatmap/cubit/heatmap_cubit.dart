// lib/presentation/Heatmap/cubit/heatmap_cubit.dart
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/domain/entities/area_score.dart';
import 'package:movin/domain/repositories/heatmap_repository.dart';
import 'package:movin/presentation/Heatmap/widgets/area_marker_layer.dart';

class HeatmapState {
  final List<AreaScore> areas;
  final Set<Marker> markers;
  final String? selectedAreaName;

  HeatmapState({
    required this.areas,
    required this.markers,
    this.selectedAreaName,
  });
}

class HeatmapCubit extends Cubit<HeatmapState> {
  final HeatmapRepository repository;
  List<AreaScore> _baseAreas = [];

  HeatmapCubit(this.repository)
      : super(HeatmapState(areas: [], markers: {}));

  Future<void> loadHeatmap() async {
    _baseAreas = await repository.getAreaScores();
    final markers = await AreaMarkerLayer.buildMarkers(_baseAreas);
    emit(HeatmapState(areas: _baseAreas, markers: markers));
  }

  Future<void> selectArea(String areaName) async {
    final origin = _baseAreas.firstWhere((a) => a.name == areaName);

    // Recalculate scores relative to selected area
    final rescored = _baseAreas.map((area) {
      final distKm = _haversineKm(origin.center, area.center);
      final score = _distanceToScore(distKm);
      return AreaScore(
        name: area.name,
        center: area.center,
        score: score,
        listingCount: area.listingCount,
        distanceKm: distKm,
      );
    }).toList();

    final markers = await AreaMarkerLayer.buildMarkers(rescored);
    emit(HeatmapState(
      areas: rescored,
      markers: markers,
      selectedAreaName: areaName,
    ));
  }

  /// Converts km distance → 0–100 score (closer = higher score = green)
  double _distanceToScore(double km) {
    if (km <= 3) return 100;
    if (km <= 8) return 70;
    if (km <= 15) return 40;
    return 10;
  }

  double _haversineKm(LatLng a, LatLng b) {
    const R = 6371.0;
    final dLat = _deg2rad(b.latitude - a.latitude);
    final dLon = _deg2rad(b.longitude - a.longitude);
    final h = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(a.latitude)) *
            cos(_deg2rad(b.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    return R * 2 * atan2(sqrt(h), sqrt(1 - h));
  }

  double _deg2rad(double deg) => deg * pi / 180;
}