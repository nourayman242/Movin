import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/data/repositories/heatmap_repository_impl.dart';
import 'package:movin/domain/entities/area_score.dart';
import 'package:movin/domain/utils/score_color_mapper.dart';
import '../cubit/heatmap_cubit.dart';

class HeatmapPage extends StatelessWidget {
  final String? initialArea;
  const HeatmapPage({super.key, this.initialArea});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HeatmapCubit(HeatmapRepositoryImpl())
            ..loadHeatmap(initialArea: initialArea),
      child: const _HeatmapView(),
    );
  }
}

class _HeatmapView extends StatefulWidget {
  const _HeatmapView();

  @override
  State<_HeatmapView> createState() => _HeatmapViewState();
}

class _HeatmapViewState extends State<_HeatmapView> {
  GoogleMapController? _mapController;
String? _pendingAnimateTo;
  void _animateTo(LatLng target) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: target, zoom: 12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HeatmapCubit, HeatmapState>(
        builder: (context, state) {
          if (_mapController != null &&
            state.selectedAreaName != null &&
            _pendingAnimateTo != state.selectedAreaName) {
          _pendingAnimateTo = state.selectedAreaName;
          final area = state.areas.firstWhere(
              (a) => a.name == state.selectedAreaName,
              orElse: () => state.areas.first);
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => _animateTo(area.center));
        }
          // ── Loading ──
          if (state.status == HeatmapStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ── Error ──
          if (state.status == HeatmapStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.wifi_off_rounded,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(state.errorMessage ?? 'Failed to load heatmap'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<HeatmapCubit>().loadHeatmap(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              // ── Map ──
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(30.0444, 31.3500),
                  zoom: 11,
                ),
                markers: state.markers,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onMapCreated: (c) => _mapController = c,
              ),

              // ── Back button ──
              Positioned(
                top: 48,
                left: 16,
                child: SafeArea(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),

              // ── Area Selector Dropdown ──
              // ── Selected area label (top-center) ──
              if (state.selectedAreaName != null)
                Positioned(
                  top: 48,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 6),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 16,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              state.selectedAreaName!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // ── Banner (below label) ──
              if (state.selectedAreaName != null)
                Positioned(
                  top: 110,
                  left: 16,
                  right: 16,
                  child: SafeArea(
                    child: _SelectedAreaBanner(
                      areas: state.areas,
                      selectedName: state.selectedAreaName!,
                    ),
                  ),
                ),

              // ── Legend ──
              Positioned(bottom: 32, left: 16, right: 16, child: _Legend()),
            ],
          );
        },
      ),
    );
  }
}

// ── Area Selector ─────────────────────────────────────────────────────────────

class _AreaSelector extends StatelessWidget {
  final List<String> areas;
  final String? selected;
  final ValueChanged<String> onChanged;

  const _AreaSelector({
    required this.areas,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: const Text('Select your area'),
          value: selected,
          items: areas
              .map((a) => DropdownMenuItem(value: a, child: Text(a)))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

// ── Selected Area Info Banner ─────────────────────────────────────────────────

class _SelectedAreaBanner extends StatelessWidget {
  final List<AreaScore> areas;
  final String selectedName;

  const _SelectedAreaBanner({required this.areas, required this.selectedName});

  @override
  Widget build(BuildContext context) {
    // Use score getter (computed from distanceKm) — NOT a stored field
    final nearby = areas
        .where((a) => a.score >= 70 && a.name != selectedName)
        .length;
    final moderate = areas.where((a) => a.score >= 40 && a.score < 70).length;
    final far = areas.where((a) => a.score < 40).length;
    final totalListings = areas.fold<int>(0, (sum, a) => sum + a.listingCount);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BannerStat(
            label: 'Nearby',
            count: nearby,
            color: ScoreColorMapper.green,
          ),
          _BannerStat(
            label: 'Moderate',
            count: moderate,
            color: ScoreColorMapper.orange,
          ),
          _BannerStat(label: 'Far', count: far, color: ScoreColorMapper.red),
          _BannerStat(
            label: 'Total listings',
            count: totalListings,
            color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}

class _BannerStat extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _BannerStat({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}

// ── Legend ────────────────────────────────────────────────────────────────────

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _LegendItem(color: ScoreColorMapper.green, label: 'Nearby (≤ 3 km)'),
          _LegendItem(
            color: ScoreColorMapper.orange,
            label: 'Moderate (≤ 8 km)',
          ),
          _LegendItem(color: ScoreColorMapper.red, label: 'Far (> 8 km)'),
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
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
