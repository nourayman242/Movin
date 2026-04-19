import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/domain/entities/area_score.dart';
import 'package:movin/domain/repositories/heatmap_repository.dart';
import 'package:movin/presentation/Heatmap/widgets/area_marker_layer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HeatmapState {
  final List<AreaScore> areas;
  final Set<Marker> markers;
  HeatmapState({required this.areas, required this.markers});
}

class HeatmapCubit extends Cubit<HeatmapState> {
  final HeatmapRepository repository;

  HeatmapCubit(this.repository)
      : super(HeatmapState(areas: [], markers: {}));

  Future<void> loadHeatmap() async {
    final areas = await repository.getAreaScores();
    final markers = await AreaMarkerLayer.buildMarkers(areas);
    emit(HeatmapState(areas: areas, markers: markers));
  }
}