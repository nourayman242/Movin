import 'package:flutter/material.dart';
import 'package:movin/presentation/home/screens/Result_page.dart';
import 'package:movin/presentation/home/widgets/filter_widgets.dart';

// Cairo areas — keep in sync with your backend's area list
const List<String> kCairoAreas = [
  'New Cairo',
  'Rehab City',
  'Madinaty',
  'Nasr City',
  'Shorouk City',
  'Heliopolis',
  'Downtown Cairo',
  'Giza',
];

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final double _minPrice = 0;
  final double _maxPrice = 100000000;
  RangeValues _priceRange = const RangeValues(0, 100000000);

  final Color navy = const Color(0xFF001F3F);
  final Color offWhite = const Color(0xFFF8F8F8);

  final TextEditingController priceMinController = TextEditingController();
  final TextEditingController priceMaxController = TextEditingController();

  String? selectedPropertyType;
  String? selectedBedrooms;
  String? selectedBathrooms;
  String? builtUpArea;
  bool? isFurnished;
  bool? hasPoolValue;
  String? selectedSort;
  String? selectedArea; // ← new

  @override
  void initState() {
    super.initState();
    priceMinController.text = _priceRange.start.toInt().toString();
    priceMaxController.text = _priceRange.end.toInt().toString();
  }

  @override
  void dispose() {
    priceMinController.dispose();
    priceMaxController.dispose();
    super.dispose();
  }

  void _updateSliderFromText() {
    double start =
        double.tryParse(priceMinController.text.replaceAll(',', '')) ??
            _minPrice;
    double end =
        double.tryParse(priceMaxController.text.replaceAll(',', '')) ??
            _maxPrice;

    start = start.clamp(_minPrice, _maxPrice);
    end = end.clamp(_minPrice, _maxPrice);
    if (start > end) start = end;

    start = (start / 100000).round() * 100000;
    end = (end / 100000).round() * 100000;

    setState(() {
      _priceRange = RangeValues(start, end);
      priceMinController.text = start.toInt().toString();
      priceMaxController.text = end.toInt().toString();
    });
  }

  void _updateTextFromSlider(RangeValues values) {
    double start = (values.start / 100000).round() * 100000;
    double end = (values.end / 100000).round() * 100000;

    setState(() {
      _priceRange = RangeValues(start, end);
      priceMinController.text = start.toInt().toString();
      priceMaxController.text = end.toInt().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      appBar: AppBar(
        backgroundColor: offWhite,
        foregroundColor: navy,
        elevation: 0,
        title: const Text("Filter Properties"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ── Area Selector Card ──────────────────────────────────
                _AreaSelectorCard(
                  navy: navy,
                  offWhite: offWhite,
                  selectedArea: selectedArea,
                  onAreaChanged: (val) => setState(() => selectedArea = val),
                ),

                const SizedBox(height: 20),

                priceRangeCard(
                  priceMinController: priceMinController,
                  priceMaxController: priceMaxController,
                  minPrice: _minPrice,
                  maxPrice: _maxPrice,
                  priceRange: _priceRange,
                  navy: navy,
                  updateSliderFromText: _updateSliderFromText,
                  updateTextFromSlider: _updateTextFromSlider,
                ),

                const SizedBox(height: 20),

                propertyTypeCard(
                  navy: navy,
                  selectedType: selectedPropertyType,
                  onTypeSelected: (type) {
                    setState(() {
                      selectedPropertyType = type;
                      selectedBedrooms = null;
                      selectedBathrooms = null;
                    });
                  },
                  selectedBedrooms: selectedBedrooms,
                  onBedroomSelected: (bed) {
                    setState(() => selectedBedrooms = bed);
                  },
                  selectedBathrooms: selectedBathrooms,
                  onBathroomSelected: (bath) {
                    setState(() => selectedBathrooms = bath);
                  },
                  builtUpArea: builtUpArea,
                  onBuiltUpAreaChanged: (val) {
                    setState(() => builtUpArea = val);
                  },
                  isFurnished: isFurnished,
                  onFurnishedChanged: (val) {
                    setState(() => isFurnished = val);
                  },
                  hasPool: hasPoolValue,
                  onPoolChanged: (value) {
                    setState(() => hasPoolValue = value);
                  },
                ),

                const SizedBox(height: 20),

                sortByCard(
                  selectedSort: selectedSort,
                  onSortChanged: (value) {
                    setState(() => selectedSort = value);
                  },
                  navy: navy,
                ),

                applyFilterButton(
                  navy: navy,
                  onPressed: () {
                    _updateSliderFromText();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResultsPage(
                          navy: navy,
                          propertyType: selectedPropertyType,
                          bedrooms: selectedBedrooms,
                          bathrooms: selectedBathrooms,
                          hasPool: hasPoolValue,
                          minPrice: _priceRange.start,
                          maxPrice: _priceRange.end,
                          sortLabel: selectedSort,
                          selectedArea: selectedArea, // ← new
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Area Selector Card ────────────────────────────────────────────────────────

class _AreaSelectorCard extends StatelessWidget {
  final Color navy;
  final Color offWhite;
  final String? selectedArea;
  final ValueChanged<String?> onAreaChanged;

  const _AreaSelectorCard({
    required this.navy,
    required this.offWhite,
    required this.selectedArea,
    required this.onAreaChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_rounded, color: navy, size: 20),
              const SizedBox(width: 8),
              Text(
                'Area',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: navy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: offWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  'Select your area',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                ),
                value: selectedArea,
                icon: Icon(Icons.keyboard_arrow_down_rounded, color: navy),
                items: kCairoAreas
                    .map((area) => DropdownMenuItem(
                          value: area,
                          child: Text(area,
                              style: const TextStyle(fontSize: 14)),
                        ))
                    .toList(),
                onChanged: onAreaChanged,
              ),
            ),
          ),
          if (selectedArea != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.info_outline_rounded,
                    size: 13, color: Colors.grey.shade500),
                const SizedBox(width: 5),
                Text(
                  'Heatmap will center on $selectedArea',
                  style: TextStyle(
                      fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}