import 'package:flutter/material.dart';
import 'package:movin/presentation/home/screens/Result_page.dart';
import 'package:movin/presentation/home/widgets/filter_widgets.dart';

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
                    // Sync text fields → slider values before navigating
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