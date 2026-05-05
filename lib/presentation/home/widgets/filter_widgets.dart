import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ── Comma formatter ──────────────────────────────────────────────────────────
/// Strips commas, formats with commas, keeps cursor sensible.
class _ThousandsFormatter extends TextInputFormatter {
  final _fmt = NumberFormat('#,###');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow empty
    if (newValue.text.isEmpty) return newValue;

    // Strip all non-digits
    final digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return newValue.copyWith(text: '');

    final number = int.tryParse(digits) ?? 0;
    final formatted = _fmt.format(number);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

// ── Price input field ────────────────────────────────────────────────────────
Widget _priceTextField(
  String hint,
  TextEditingController controller, {
  required Color navy,
  String? prefix,
  Function(String)? onSubmitted,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
      ],
    ),
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onSubmitted: onSubmitted,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _ThousandsFormatter(),
      ],
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: navy,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontWeight: FontWeight.w400,
          fontSize: 13,
        ),
        prefixText: prefix,
        prefixStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade500,
        ),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
    ),
  );
}

// ── Price Range Card ─────────────────────────────────────────────────────────
Widget priceRangeCard({
  required TextEditingController priceMinController,
  required TextEditingController priceMaxController,
  required double minPrice,
  required double maxPrice,
  required RangeValues priceRange,
  required Color navy,
  required VoidCallback updateSliderFromText,
  required Function(RangeValues) updateTextFromSlider,
}) {
  final _labelFmt = NumberFormat('#,###');

  String _sliderLabel(double val) {
    if (val >= 1000000) {
      return 'EGP ${(val / 1000000).toStringAsFixed(1)}M';
    }
    if (val >= 1000) {
      return 'EGP ${(val / 1000).toStringAsFixed(0)}K';
    }
    return 'EGP ${val.toInt()}';
  }

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6)),
      ],
    ),
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Icon(Icons.payments_rounded, color: navy, size: 20),
            const SizedBox(width: 8),
            Text(
              'Price Range',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: navy,
              ),
            ),
            const Spacer(),
            // Live range pill
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: navy.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Builder(builder: (_) {
                return Text(
                  '${_sliderLabel(priceRange.start)} – ${_sliderLabel(priceRange.end)}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: navy,
                  ),
                );
              }),
            ),
          ],
        ),

        const SizedBox(height: 18),

        // Min / Max inputs
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Min (EGP)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _priceTextField(
                    '0',
                    priceMinController,
                    navy: navy,
                    onSubmitted: (_) => updateSliderFromText(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '–',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Max (EGP)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _priceTextField(
                    '10,000,000',
                    priceMaxController,
                    navy: navy,
                    onSubmitted: (_) => updateSliderFromText(),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        // Slider
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: navy,
            inactiveTrackColor: Colors.grey.shade200,
            thumbColor: navy,
            overlayColor: navy.withOpacity(0.12),
            trackHeight: 4,
            thumbShape:
                const RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: RangeSlider(
            values: priceRange,
            min: minPrice,
            max: maxPrice,
            divisions: (maxPrice ~/ 100000),
            labels: RangeLabels(
              _sliderLabel(priceRange.start),
              _sliderLabel(priceRange.end),
            ),
            onChanged: updateTextFromSlider,
          ),
        ),

        // Min / Max axis labels
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'EGP 0',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
              ),
              Text(
                'EGP ${_labelFmt.format(maxPrice.toInt())}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ── Property Type Card ────────────────────────────────────────────────────────
Widget propertyTypeCard({
  required Color navy,
  required String? selectedType,
  required Function(String) onTypeSelected,
  String? builtUpArea,
  required Function(String) onBuiltUpAreaChanged,
  bool? isFurnished,
  required Function(bool?) onFurnishedChanged,
  bool? hasPool,
  required Function(bool?) onPoolChanged,
  String? selectedBedrooms,
  required Function(String) onBedroomSelected,
  String? selectedBathrooms,
  required Function(String) onBathroomSelected,
}) {
  final List<String> types = ["Apartment", "Villa", "Studio", "Penthouse"];
  final List<String> bedroomOptions = ["1", "2", "3", "4", "5+"];
  final List<String> bathroomOptions = ["1", "2", "3", "4", "5+"];

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6)),
      ],
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Property Type",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(height: 12),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: types.map((type) {
            bool isSelected = selectedType == type;
            return Expanded(
              child: GestureDetector(
                onTap: () => onTypeSelected(type),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? navy : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      type,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        if (selectedType == "Apartment" ||
            selectedType == "Villa" ||
            selectedType == "Penthouse") ...[
          const Text("Bedrooms",
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: bedroomOptions.map((b) {
              bool isSelected = selectedBedrooms == b;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onBedroomSelected(b),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? navy : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        b,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          const Text("Bathrooms",
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: bathroomOptions.map((b) {
              bool isSelected = selectedBathrooms == b;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onBathroomSelected(b),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? navy : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        b,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],

        if (selectedType == "Villa") ...[
          const SizedBox(height: 16),
          const Text("Pool", style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      onPoolChanged(hasPool == true ? null : true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: (hasPool == true) ? navy : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          color: (hasPool == true)
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      onPoolChanged(hasPool == false ? null : false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: (hasPool == false) ? navy : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "No",
                        style: TextStyle(
                          color: (hasPool == false)
                              ? Colors.white
                              : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],

        const SizedBox(height: 8),
        const Text(
          "Built-Up Area (m²)",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: onBuiltUpAreaChanged,
            decoration: const InputDecoration(
              hintText: "Enter area",
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            ),
          ),
        ),

        const SizedBox(height: 20),
        const Text("Furnished",
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () =>
                    onFurnishedChanged(isFurnished == true ? null : true),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: isFurnished == true ? navy : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: isFurnished == true
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () =>
                    onFurnishedChanged(isFurnished == false ? null : false),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: isFurnished == false ? navy : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "No",
                      style: TextStyle(
                        color: isFurnished == false
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ── Sort By Card ──────────────────────────────────────────────────────────────
Widget sortByCard({
  required String? selectedSort,
  required Function(String?) onSortChanged,
  required Color navy,
}) {
  // Each entry: display label → SortOption
  final List<Map<String, dynamic>> sortOptions = [
    {
      'label': 'Price: Low to High',
      'icon': Icons.arrow_upward_rounded,
    },
    {
      'label': 'Price: High to Low',
      'icon': Icons.arrow_downward_rounded,
    },
    {
      'label': 'Newest First',
      'icon': Icons.schedule_rounded,
    },
    {
      'label': 'Most Popular',
      'icon': Icons.trending_up_rounded,
    },
  ];

  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF9F9F9),
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 5)),
      ],
    ),
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sort_rounded, color: navy, size: 20),
            const SizedBox(width: 8),
            Text(
              'Sort By',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: navy,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Tap-to-select chip row (2×2 grid)
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: sortOptions.map((opt) {
            final label = opt['label'] as String;
            final icon = opt['icon'] as IconData;
            final isSelected = selectedSort == label;

            return GestureDetector(
              onTap: () => onSortChanged(isSelected ? null : label),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? navy : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isSelected ? navy : Colors.grey.shade300,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: navy.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          )
                        ]
                      : [
                          const BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          )
                        ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      size: 16,
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? Colors.white : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// ── Apply Filter Button ───────────────────────────────────────────────────────
Widget applyFilterButton({
  required VoidCallback onPressed,
  required Color navy,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: navy,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: const Center(
        child: Text(
          "Apply Filters",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    ),
  );
}