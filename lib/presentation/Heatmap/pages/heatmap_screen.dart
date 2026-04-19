import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/data/repositories/heatmap_repository_impl.dart';
import 'package:movin/domain/utils/score_color_mapper.dart';
import '../cubit/heatmap_cubit.dart';

class HeatmapPage extends StatelessWidget {
  const HeatmapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HeatmapCubit(HeatmapRepositoryImpl())..loadHeatmap(),
      child: const _HeatmapView(),
    );
  }
}

class _HeatmapView extends StatelessWidget {
  const _HeatmapView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HeatmapCubit, HeatmapState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(30.0444, 31.3500), // centered between areas
                  zoom: 11,
                ),
                markers: state.markers,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
              // ── Legend ──
              Positioned(
                bottom: 32,
                left: 16,
                right: 16,
                child: _Legend(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _LegendItem(color: ScoreColorMapper.green,  label: 'Nearby match'),
          _LegendItem(color: ScoreColorMapper.orange, label: 'Moderate'),
          _LegendItem(color: ScoreColorMapper.red,    label: 'Far away'),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10, height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}