import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/data/repositories/heatmap_repository_impl.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/domain/entities/area_score.dart';
import 'package:movin/domain/utils/score_color_mapper.dart';
import 'package:movin/presentation/Property_detials/screens/property_detials.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';
import '../cubit/heatmap_cubit.dart';

// heatmap_screen.dart
class HeatmapPage extends StatelessWidget {
  final String? initialArea;
  final String? propertyType;
  final String? bedrooms;
  final String? bathrooms;
  final bool? hasPool;
  final double? minPrice;
  final double? maxPrice;

  const HeatmapPage({
    super.key,
    this.initialArea,
    this.propertyType,
    this.bedrooms,
    this.bathrooms,
    this.hasPool,
    this.minPrice,
    this.maxPrice,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HeatmapCubit(HeatmapRepositoryImpl())
        ..loadHeatmap(
          initialArea: initialArea,
          propertyType: propertyType,
          bedrooms: bedrooms,
          bathrooms: bathrooms,
          hasPool: hasPool,
          minPrice: minPrice,
          maxPrice: maxPrice,
        ),
      child: _HeatmapView(initialArea: initialArea),
    );
  }
}

class _HeatmapView extends StatefulWidget {
  final String? initialArea;
  const _HeatmapView({this.initialArea});

  @override
  State<_HeatmapView> createState() => _HeatmapViewState();
}

class _HeatmapViewState extends State<_HeatmapView> {
  GoogleMapController? _mapController;

  void _showListingsSheet(BuildContext context, AreaScore area) {
    final pageContext = context;

    showModalBottomSheet(
      context: pageContext,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, scrollController) => Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${area.listingCount} listings in ${area.name}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: area.listings.isEmpty
                    ? const Center(child: Text('No listings available'))
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: area.listings.length,
                        itemBuilder: (_, index) {
                          final property = area.listings[index];
                          return InkWell(
                            onTap: () async {
                              Navigator.pop(pageContext);
                              await Navigator.push(
                                pageContext,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: getIt<PropertyCubit>(),
                                    child: PropertyDetailsScreen(
                                      propertyId: property.id,
                                    ),
                                  ),
                                ),
                              );
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: ListTile(
                              tileColor: Colors.white,
                              leading: property.images.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.network(
                                        property.images.first,
                                        width: 56,
                                        height: 56,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) =>
                                            const Icon(
                                              Icons.home_rounded,
                                              size: 40,
                                            ),
                                      ),
                                    )
                                  : const Icon(Icons.home_rounded, size: 40),
                              title: Text(property.type),
                              subtitle: Text(
                                '${property.price} EGP · ${property.size}',
                              ),
                              trailing: const Icon(Icons.chevron_right),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HeatmapCubit, HeatmapState>(
      listenWhen: (prev, curr) => curr.tappedArea != null,
      listener: (context, state) {
        _showListingsSheet(context, state.tappedArea!);
        context.read<HeatmapCubit>().clearTappedArea();
      },
      child: Scaffold(
        body: BlocBuilder<HeatmapCubit, HeatmapState>(
          builder: (context, state) {
            // ── Loading ─────────────────────────────────────────────
            if (state.status == HeatmapStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            // ── Error ───────────────────────────────────────────────
            if (state.status == HeatmapStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage ?? 'Failed to load heatmap'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<HeatmapCubit>().loadHeatmap(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            // ── Loaded ──────────────────────────────────────────────
            return Stack(
              children: [
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

                // stats banner — shows if initialArea was passed
                if (widget.initialArea != null && state.areas.isNotEmpty)
                  Positioned(
                    top: 48,
                    left: 16,
                    right: 16,
                    child: SafeArea(
                      child: _SelectedAreaBanner(
                        areas: state.areas,
                        selectedName: widget.initialArea!,
                      ),
                    ),
                  ),

                Positioned(bottom: 32, left: 16, right: 16, child: _Legend()),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Selected Area Stats Banner ────────────────────────────────────────────────

class _SelectedAreaBanner extends StatelessWidget {
  final List<AreaScore> areas;
  final String selectedName;

  const _SelectedAreaBanner({required this.areas, required this.selectedName});

  @override
  Widget build(BuildContext context) {
    final selected = areas.firstWhere((a) => a.name == selectedName);

    final nearbyListings = areas
        .where((a) => a.score >= 70)
        .fold<int>(0, (sum, a) => sum + a.listingCount);

    final moderateListings = areas
        .where((a) => a.score >= 40 && a.score < 70)
        .fold<int>(0, (sum, a) => sum + a.listingCount);

    final farListings = areas
        .where((a) => a.score < 40)
        .fold<int>(0, (sum, a) => sum + a.listingCount);

    final totalListings = areas.fold<int>(0, (sum, a) => sum + a.listingCount);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${selected.listingCount} listings in $selectedName',
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BannerStat(
                label: 'Nearby',
                count: nearbyListings,
                color: ScoreColorMapper.green,
              ),
              _BannerStat(
                label: 'Moderate',
                count: moderateListings,
                color: ScoreColorMapper.orange,
              ),
              _BannerStat(
                label: 'Far',
                count: farListings,
                color: ScoreColorMapper.red,
              ),
              _BannerStat(
                label: 'Total',
                count: totalListings,
                color: Colors.blueGrey,
              ),
            ],
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

// ── Legend ───────────────────────────────────────────────────────────────────

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
