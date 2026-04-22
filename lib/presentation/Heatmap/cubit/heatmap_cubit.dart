import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/domain/entities/area_score.dart';
import 'package:movin/domain/repositories/heatmap_repository.dart';
import 'package:movin/presentation/Heatmap/widgets/area_marker_layer.dart';

// ── State ─────────────────────────────────────────────────────────────────────

enum HeatmapStatus { initial, loading, loaded, error }

class HeatmapState {
  final HeatmapStatus status;
  final List<AreaScore> areas;
  final Set<Marker> markers;
  final String? selectedAreaName;
  final String? errorMessage;

  const HeatmapState({
    this.status = HeatmapStatus.initial,
    this.areas = const [],
    this.markers = const {},
    this.selectedAreaName,
    this.errorMessage,
  });

  HeatmapState copyWith({
    HeatmapStatus? status,
    List<AreaScore>? areas,
    Set<Marker>? markers,
    String? selectedAreaName,
    String? errorMessage,
  }) {
    return HeatmapState(
      status: status ?? this.status,
      areas: areas ?? this.areas,
      markers: markers ?? this.markers,
      selectedAreaName: selectedAreaName ?? this.selectedAreaName,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ── Cubit ─────────────────────────────────────────────────────────────────────

class HeatmapCubit extends Cubit<HeatmapState> {
  final HeatmapRepository repository;
  List<AreaScore> _baseAreas = [];

  HeatmapCubit(this.repository) : super(const HeatmapState());

  Future<void> loadHeatmap({String? initialArea}) async {
  emit(state.copyWith(status: HeatmapStatus.loading));
  try {
    _baseAreas = await repository.getAreaScores();

    // If an area was pre-selected from the filter screen, apply it immediately
    if (initialArea != null &&
        _baseAreas.any((a) => a.name == initialArea)) {
      await selectArea(initialArea);
    } else {
      final markers = await AreaMarkerLayer.buildMarkers(_baseAreas);
      emit(state.copyWith(
        status: HeatmapStatus.loaded,
        areas: _baseAreas,
        markers: markers,
      ));
    }
  } catch (e) {
    emit(state.copyWith(
      status: HeatmapStatus.error,
      errorMessage: e.toString(),
    ));
  }
}

Future<void> selectArea(String areaName) async {
  final origin = _baseAreas.firstWhere((a) => a.name == areaName);

  final rescored = _baseAreas.map((area) {
    final distKm = _haversineKm(origin.center, area.center);
    return AreaScore(
      name: area.name,
      center: area.center,
      listingCount: area.listingCount,
      distanceKm: distKm,
    );
  }).toList();

  final markers = await AreaMarkerLayer.buildMarkers(
    rescored,
    selectedAreaName: areaName,
  );

  emit(state.copyWith(
    status: HeatmapStatus.loaded,
    areas: rescored,
    markers: markers,
    selectedAreaName: areaName,
  ));
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