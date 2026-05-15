import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/domain/entities/area_score.dart';
import 'package:movin/domain/repositories/heatmap_repository.dart';
import 'package:movin/presentation/Heatmap/widgets/area_marker_layer.dart';

enum HeatmapStatus { initial, loading, loaded, error }

class HeatmapState {
  final HeatmapStatus status;
  final List<AreaScore> areas;
  final Set<Marker> markers;
  final String? errorMessage;
  final AreaScore? tappedArea;

  const HeatmapState({
    this.status = HeatmapStatus.initial,
    this.areas = const [],
    this.markers = const {},
    this.errorMessage,
    this.tappedArea,
  });

  HeatmapState copyWith({
    HeatmapStatus? status,
    List<AreaScore>? areas,
    Set<Marker>? markers,
    String? errorMessage,
    AreaScore? tappedArea,
    bool clearTappedArea = false,
  }) {
    return HeatmapState(
      status: status ?? this.status,
      areas: areas ?? this.areas,
      markers: markers ?? this.markers,
      errorMessage: errorMessage ?? this.errorMessage,
      tappedArea: clearTappedArea ? null : (tappedArea ?? this.tappedArea),
    );
  }
}

class HeatmapCubit extends Cubit<HeatmapState> {
  final HeatmapRepository repository;

  HeatmapCubit(this.repository) : super(const HeatmapState());

  Future<void> loadHeatmap({
  String? initialArea,
  String? propertyType,
  String? bedrooms,
  String? bathrooms,
  bool? hasPool,
  double? minPrice,
  double? maxPrice,
}) async {
  emit(state.copyWith(status: HeatmapStatus.loading));
    try {
      final rawAreas = await repository.getAreaScores(
      propertyType: propertyType,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      hasPool: hasPool,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );

      List<AreaScore> areas;

      if (initialArea != null &&
          rawAreas.any((a) => a.name == initialArea)) {

        final origin = rawAreas.firstWhere((a) => a.name == initialArea);
        areas = rawAreas.map((area) {
          final distKm = area.name == initialArea
              ? 0.0 
              : _haversineKm(origin.center, area.center);
          return AreaScore(
            name: area.name,
            center: area.center,
            listingCount: area.listingCount,
            distanceKm: distKm,
            listings: area.listings,
          );
        }).toList();
      } else {

        areas = rawAreas;
      }


      final markers = await AreaMarkerLayer.buildMarkers(
        areas,
        onTap: (area) => emit(state.copyWith(tappedArea: area)),
      );

      emit(state.copyWith(
        status: HeatmapStatus.loaded,
        areas: areas,
        markers: markers,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HeatmapStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void clearTappedArea() {
    emit(state.copyWith(clearTappedArea: true));
  }

  double _haversineKm(LatLng a, LatLng b) {
    const R = 6371.0;
    final dLat = _deg2rad(b.latitude - a.latitude);
    final dLon = _deg2rad(b.longitude - a.longitude);
    final h =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(a.latitude)) *
            cos(_deg2rad(b.latitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    return R * 2 * atan2(sqrt(h), sqrt(1 - h));
  }

  double _deg2rad(double deg) => deg * pi / 180;
}