import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Shadowed TextField (reusable)
Widget _shadowTextField(
  String hint,
  TextEditingController controller, {
  required Color navy,
  bool number = false,
  Function(String)? onSubmitted,
  List<TextInputFormatter>? inputFormatters,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
      ],
    ),
    child: TextField(
      controller: controller,
      keyboardType: number ? TextInputType.number : TextInputType.text,
      onSubmitted: onSubmitted,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
    ),
  );
}

// Price Range Card
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
          "Price Range",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Min",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  _shadowTextField(
                    "Min Price",
                    priceMinController,
                    navy: navy,
                    number: true,
                    onSubmitted: (_) => updateSliderFromText(),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Max",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  _shadowTextField(
                    "Max Price",
                    priceMaxController,
                    navy: navy,
                    number: true,
                    onSubmitted: (_) => updateSliderFromText(),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        RangeSlider(
          values: priceRange,
          min: minPrice,
          max: maxPrice,
          divisions: (maxPrice ~/ 100000),
          activeColor: navy,
          inactiveColor: Colors.grey[300],
          onChanged: updateTextFromSlider,
        ),
      ],
    ),
  );
}

// Property Type Card with dynamic sub-options
Widget propertyTypeCard({
  required Color navy,
  required String? selectedType,
  required Function(String) onTypeSelected,

  // Apartment
  String? builtUpArea,
  required Function(String) onBuiltUpAreaChanged,
  bool? isFurnished,
  required Function(bool?) onFurnishedChanged,

  // Villa
  bool? hasPool,
  required Function(bool?) onPoolChanged,

  // Shared
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

        // PROPERTY TYPE BUTTONS
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
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        // BEDROOMS & BATHROOMS ONLY FOR APARTMENT
        if (selectedType == "Apartment" ||
            selectedType == "Villa" ||
            selectedType == "Penthouse") ...[
          const Text("Bedrooms", style: TextStyle(fontWeight: FontWeight.w600)),
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

          const Text(
            "Bathrooms",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
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
                  onTap: () {
                    if (hasPool == true) {
                      onPoolChanged(null);
                    } else {
                      onPoolChanged(true);
                    }
                  },
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
                  onTap: () {
                    if (hasPool == false) {
                      onPoolChanged(null);
                    } else {
                      onPoolChanged(false);
                    }
                  },
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

        /// ---------------------------
        /// BUILT-UP AREA FIELD
        /// ---------------------------
        const SizedBox(height: 8),
        const Text(
          "Built-Up Area (sqft)",
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
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        /// ---------------------------
        /// FURNISHED TOGGLE
        /// ---------------------------
        const Text("Furnished", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isFurnished == true) {
                    onFurnishedChanged(null);
                  } else {
                    onFurnishedChanged(true);
                  }
                },
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
                onTap: () {
                  if (isFurnished == false) {
                    onFurnishedChanged(null);
                  } else {
                    onFurnishedChanged(false);
                  }
                },
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

// Sort By Dropdown
// SORT BY CARD
Widget sortByCard({
  required String? selectedSort,
  required Function(String?) onSortChanged,
  required Color navy,
}) {
  final List<String> sortOptions = [
    "Newest",
    "Price: Low to High",
    "Price: High to Low",
    "Most Popular",
  ];

  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFF9F9F9), // Off-white modern color
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 5)),
      ],
    ),
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sort By",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
        const SizedBox(height: 14),

        // 🔥 MODERN DROPDOWN UI
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFDFDFD),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<String>(
              value: selectedSort,
              dropdownColor: const Color(0xFFFDFDFD),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),

              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: navy,
                size: 28,
              ),

              style: TextStyle(
                fontSize: 15.5,
                color: navy,
                fontWeight: FontWeight.w600,
              ),

              hint: Text(
                "Select Sort Option",
                style: TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w500,
                  color: navy.withOpacity(0.6),
                ),
              ),

              items: sortOptions.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Row(
                    children: [
                      Icon(Icons.sort_rounded, size: 20, color: navy),
                      const SizedBox(width: 10),
                      Text(
                        value,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              onChanged: onSortChanged,

              menuMaxHeight: 260,
            ),
          ),
        ),
      ],
    ),
  );
}
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
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
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