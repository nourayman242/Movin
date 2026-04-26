import 'package:flutter/material.dart';
import 'package:movin/data/api_services/filter_services.dart';
import 'package:movin/data/models/property_model.dart';
import 'package:movin/presentation/Heatmap/pages/heatmap_screen.dart';

class ResultsPage extends StatefulWidget {
  final Color navy;

  // Raw filter values passed from FilterScreen
  final String? propertyType;
  final String? bedrooms;
  final String? bathrooms;
  final bool? hasPool;
  final double minPrice;
  final double maxPrice;
  final String? sortLabel;
  final String? selectedArea;
  const ResultsPage({
    super.key,
    required this.navy,
    this.propertyType,
    this.bedrooms,
    this.bathrooms,
    this.hasPool,
    required this.minPrice,
    required this.maxPrice,
    this.sortLabel,
    this.selectedArea,
  });

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  late Future<FilteredPropertiesResponse> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchProperties();
  }

  Future<FilteredPropertiesResponse> _fetchProperties() {
    return FilterService.fetchFilteredProperties(
      type: widget.propertyType,
      bedrooms: widget.bedrooms,
      bathrooms: widget.bathrooms,
      pool: widget.hasPool,
      minPrice: widget.minPrice,
      maxPrice: widget.maxPrice,
      sort: FilterService.mapSortToApi(widget.sortLabel),
    );
  }

  // Build active filter chip labels for the AppBar
  List<String> get _activeChips {
    final chips = <String>[];
    if (widget.selectedArea != null)chips.add('📍 ${widget.selectedArea}'); 
    if (widget.propertyType != null) chips.add(widget.propertyType!);
    if (widget.propertyType != null) chips.add(widget.propertyType!);
    if (widget.bedrooms != null) chips.add('${widget.bedrooms} Bed');
    if (widget.bathrooms != null) chips.add('${widget.bathrooms} Bath');
    if (widget.hasPool == true) chips.add('Pool');
    if (widget.minPrice > 0) chips.add('Min ${_fmt(widget.minPrice)}');
    if (widget.maxPrice < 100000000) chips.add('Max ${_fmt(widget.maxPrice)}');
    if (widget.sortLabel != null) chips.add(widget.sortLabel!);
    return chips;
  }

  String _fmt(double v) {
    if (v >= 1000000) return 'EGP ${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return 'EGP ${(v / 1000).toStringAsFixed(0)}K';
    return 'EGP ${v.toInt()}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FilteredPropertiesResponse>(
      future: _future,
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;
        final total = snapshot.data?.total ?? 0;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F8F8),
          appBar: AppBar(
            backgroundColor: widget.navy,
            elevation: 0,
            automaticallyImplyLeading: false,
            toolbarHeight: _activeChips.isNotEmpty ? 160 : 130,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back + Title row
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "Results",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                // Result count
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: isLoading
                      ? const Text(
                          "Loading...",
                          style: TextStyle(color: Colors.white70, fontSize: 15),
                        )
                      : Text(
                          "$total ${total == 1 ? 'result' : 'results'} found",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                ),

                const SizedBox(height: 10),

                // Edit Filter + Sort By buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: widget.navy.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.white30, width: 1),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.tune, color: Colors.white, size: 18),
                              SizedBox(width: 6),
                              Text(
                                "Edit Filter",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (widget.sortLabel != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: widget.navy.withOpacity(0.85),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.white30, width: 1),
                          ),
                          child: Text(
                            widget.sortLabel!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Active filter chips
                if (_activeChips.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 32,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      children: _activeChips.map((chip) {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white38, width: 1),
                          ),
                          child: Text(
                            chip,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
              ],
            ),
          ),

          // ── Heatmap FAB ──────────────────────────────────────────────────────
          floatingActionButton: _HeatmapFab(navy: widget.navy,selectedArea: widget.selectedArea,),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

          body: _buildBody(snapshot),
        );
      },
    );
  }

  Widget _buildBody(AsyncSnapshot<FilteredPropertiesResponse> snapshot) {
    // Loading state
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator(color: widget.navy));
    }

    // Error state
    if (snapshot.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off_rounded, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text(
                "Something went wrong",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => setState(() => _future = _fetchProperties()),
                icon: const Icon(Icons.refresh),
                label: const Text("Retry"),
                style: ElevatedButton.styleFrom(backgroundColor: widget.navy),
              ),
            ],
          ),
        ),
      );
    }

    // Empty state
    final properties = snapshot.data?.properties ?? [];
    if (properties.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off_rounded, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            const Text(
              "No properties found",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              "Try adjusting your filters",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.tune),
              label: const Text("Edit Filters"),
              style: ElevatedButton.styleFrom(backgroundColor: widget.navy),
            ),
          ],
        ),
      );
    }

    // Results list
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: properties.length,
      itemBuilder: (context, index) {
        return _PropertyCard(property: properties[index], navy: widget.navy);
      },
    );
  }
}

// ── Heatmap FAB ───────────────────────────────────────────────────────────────
class _HeatmapFab extends StatelessWidget {
  final Color navy;
  final String? selectedArea;
   const _HeatmapFab({required this.navy, this.selectedArea});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Push it down so it sits just below the curved AppBar
      padding: const EdgeInsets.only(top: 16),
      child: FloatingActionButton.extended(
        heroTag: 'heatmap_fab',
        backgroundColor: navy,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => HeatmapPage(
              initialArea: selectedArea,
            )),
          );
        },
        icon: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow layer for heatmap feel
            Icon(
              Icons.map_rounded,
              color: Colors.white.withOpacity(0.25),
              size: 28,
            ),
            const Icon(Icons.map_rounded, color: Colors.white, size: 22),
            // Small flame/heat dot overlay
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFF5C5C),
                ),
              ),
            ),
          ],
        ),
        label: const Text(
          "Heat Map",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

// ── Property Card ─────────────────────────────────────────────────────────────
class _PropertyCard extends StatelessWidget {
  final PropertyModel property;
  final Color navy;

  const _PropertyCard({required this.property, required this.navy});

  String _formatPrice(int price) {
    if (price >= 1000000) {
      return 'EGP ${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return 'EGP ${(price / 1000).toStringAsFixed(0)}K';
    }
    return 'EGP $price';
  }

  @override
  Widget build(BuildContext context) {
    final details = property.details;
    final isRent = property.listingType == 'rent';
    final firstImage = property.images.isNotEmpty
        ? property.images.first
        : null;

    // Extract detail fields from the details map
    final String? bedrooms = details['bedrooms']?.toString();
    final String? bathrooms = details['bathrooms']?.toString();
    final String? size = details['size']?.toString();
    final bool hasPool = details['pool']?.toString() == 'true';
    final bool hasGarden = details['garden']?.toString() == 'true';
    final String? floor = details['floor']?.toString();
    final bool hasElevator = details['elevator']?.toString() == 'true';
    final bool isFurnished = details['furnished']?.toString() == 'true';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image ──
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: firstImage != null
                ? Image.network(
                    firstImage,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholder(),
                    loadingBuilder: (_, child, progress) =>
                        progress == null ? child : _placeholder(),
                  )
                : _placeholder(),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Badges row ──
                Row(
                  children: [
                    _badge(
                      isRent ? "For Rent" : "For Sale",
                      isRent ? Colors.orange : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    _badge(
                      property.type[0].toUpperCase() +
                          property.type.substring(1),
                      navy,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ── Location + Price ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded, color: navy, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          property.location,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _formatPrice(property.price),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: navy,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // ── Description ──
                Text(
                  property.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 12),

                // ── Detail chips ──
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    if (bedrooms != null)
                      _chip(Icons.bed_rounded, '$bedrooms Beds'),
                    if (bathrooms != null)
                      _chip(Icons.bathtub_rounded, '$bathrooms Baths'),
                    if (size != null && size.isNotEmpty)
                      _chip(Icons.straighten_rounded, size),
                    if (hasPool) _chip(Icons.pool_rounded, 'Pool'),
                    if (hasGarden) _chip(Icons.park_rounded, 'Garden'),
                    if (floor != null)
                      _chip(Icons.layers_rounded, 'Floor $floor'),
                    if (hasElevator) _chip(Icons.elevator_rounded, 'Elevator'),
                    if (isFurnished) _chip(Icons.chair_rounded, 'Furnished'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color == navy ? navy : Color.lerp(color, Colors.black, 0.3),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[700]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[200],
      child: Icon(Icons.home_rounded, size: 60, color: Colors.grey[400]),
    );
  }
}
