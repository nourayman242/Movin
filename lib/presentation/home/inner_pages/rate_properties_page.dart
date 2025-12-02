import 'package:flutter/material.dart';

class RatePropertiesPage extends StatefulWidget {
  const RatePropertiesPage({super.key});

  @override
  State<RatePropertiesPage> createState() => _RatePropertiesPageState();
}

class _RatePropertiesPageState extends State<RatePropertiesPage> {
  final Color navy = const Color(0xFF001F3F);
  final Color offWhite = const Color(0xFFF8F8F8);
  final Color gold = const Color(0xFFFFD700);

  List<Map<String, dynamic>> ratedProperties = [];

  final TextEditingController cityController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController bedroomsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController landAreaController = TextEditingController();
  final TextEditingController builtUpAreaController = TextEditingController();
  final TextEditingController numberOfFloorsController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedType;
  bool? furnished;
  bool? hasGarden;
  bool? hasPool;
  bool? hasTerrace;

  final List<String> propertyTypes = [
    "Apartment",
    "Villa",
    "Studio",
    "Penthouse",
  ];

  bool _validate() {
    List<String> missingFields = [];

    if (selectedType == null) missingFields.add("Property Type");
    if (cityController.text.trim().isEmpty) missingFields.add("City");
    if (locationController.text.trim().isEmpty) missingFields.add("Location");

    switch (selectedType) {
      case "Apartment":
        if (bedroomsController.text.trim().isEmpty) missingFields.add("Bedrooms");
        if (bathroomsController.text.trim().isEmpty) missingFields.add("Bathrooms");
        if (sizeController.text.trim().isEmpty) missingFields.add("Size");
        if (floorController.text.trim().isEmpty) missingFields.add("Floor");
        if (furnished == null) missingFields.add("Furnished");
        break;

      case "Villa":
        if (bedroomsController.text.trim().isEmpty) missingFields.add("Bedrooms");
        if (bathroomsController.text.trim().isEmpty) missingFields.add("Bathrooms");
        if (landAreaController.text.trim().isEmpty) missingFields.add("Land Area");
        if (builtUpAreaController.text.trim().isEmpty) missingFields.add("Built-up Area");
        if (numberOfFloorsController.text.trim().isEmpty)
          missingFields.add("Number of Floors");
        if (hasGarden == null) missingFields.add("Has Garden");
        if (hasPool == null) missingFields.add("Has Pool");
        break;

      case "Studio":
        if (sizeController.text.trim().isEmpty) missingFields.add("Size");
        if (furnished == null) missingFields.add("Furnished");
        break;

      case "Penthouse":
        if (bedroomsController.text.trim().isEmpty) missingFields.add("Bedrooms");
        if (bathroomsController.text.trim().isEmpty) missingFields.add("Bathrooms");
        if (sizeController.text.trim().isEmpty) missingFields.add("Size");
        if (floorController.text.trim().isEmpty) missingFields.add("Floor");
        if (hasTerrace == null) missingFields.add("Has Terrace");
        break;
    }

    if (missingFields.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "⚠️ Please fill the required fields: ${missingFields.join(", ")}",
        ),
        backgroundColor: Colors.redAccent,
      ));
      return false;
    }

    return true;
  }

  // void _addProperty() {
  //   if (!_validate()) return;

  //   final property = {
  //     "type": selectedType!,
  //     "city": cityController.text.trim(),
  //     "location": locationController.text.trim(),
  //     "bedrooms": bedroomsController.text.trim(),
  //     "bathrooms": bathroomsController.text.trim(),
  //     "size": sizeController.text.trim(),
  //     "floor": floorController.text.trim(),
  //     "furnished": furnished,
  //     "landArea": landAreaController.text.trim(),
  //     "builtUpArea": builtUpAreaController.text.trim(),
  //     "numberOfFloors": numberOfFloorsController.text.trim(),
  //     "hasGarden": hasGarden,
  //     "hasPool": hasPool,
  //     "hasTerrace": hasTerrace,
  //     "description": descriptionController.text.trim(),
  //     "predictedPrice": "2,000,000 EGP",
  //   };

  //   setState(() {
  //     ratedProperties.add(property);

  //     // Clear form
  //     selectedType = null;
  //     cityController.clear();
  //     locationController.clear();
  //     bedroomsController.clear();
  //     bathroomsController.clear();
  //     sizeController.clear();
  //     floorController.clear();
  //     landAreaController.clear();
  //     builtUpAreaController.clear();
  //     numberOfFloorsController.clear();
  //     descriptionController.clear();
  //     furnished = null;
  //     hasGarden = null;
  //     hasPool = null;
  //     hasTerrace = null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      appBar: AppBar(
        backgroundColor: offWhite,
        title: const Text("Rate Property"),
        foregroundColor: navy,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            _labelWithAsterisk("Property Type"),
            const SizedBox(height: 6),
            CustomInlineDropdown(
              items: propertyTypes,
              value: selectedType,
              navy: navy,
              gold: gold,
              hint: "Select property type",
              onChanged: (v) => setState(() => selectedType = v),
            ),

            const SizedBox(height: 12),
            _labelWithAsterisk("City"),
            const SizedBox(height: 6),
            _shadowTextField("City", cityController),
            const SizedBox(height: 12),
            _labelWithAsterisk("Location / Area"),
            const SizedBox(height: 6),
            _shadowTextField("Location / Area", locationController),

            const SizedBox(height: 12),

            if (selectedType == "Apartment") ...[
              _labelWithAsterisk("Bedrooms"),
              const SizedBox(height: 6),
              _shadowTextField("Bedrooms", bedroomsController, number: true),
              const SizedBox(height: 12),
              _labelWithAsterisk("Bathrooms"),
              const SizedBox(height: 6),
              _shadowTextField("Bathrooms", bathroomsController, number: true),
              const SizedBox(height: 12),
              _labelWithAsterisk("Size (m²)"),
              const SizedBox(height: 6),
              _shadowTextField("Size (m²)", sizeController, number: true),
              const SizedBox(height: 12),
              _labelWithAsterisk("Floor"),
              const SizedBox(height: 6),
              _shadowTextField("Floor", floorController, number: true),
              const SizedBox(height: 12),
              _labelWithAsterisk("Furnished"),
              Row(
                children: [
                  Expanded(
                    child: _roundedChoice(
                      label: "Yes",
                      selected: furnished == true,
                      onTap: () => setState(() => furnished = true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _roundedChoice(
                      label: "No",
                      selected: furnished == false,
                      onTap: () => setState(() => furnished = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text("Description (optional)", style: TextStyle(color: navy)),
              const SizedBox(height: 6),
              _shadowTextField(
                "Description",
                descriptionController,
                multi: true,
              ),
            ],

            if (selectedType == "Villa") ...[
              _labelWithAsterisk("Bedrooms"),
              const SizedBox(height: 6),
              _shadowTextField("Bedrooms", bedroomsController, number: true),
              const SizedBox(height: 12),
              _labelWithAsterisk("Bathrooms"),
              const SizedBox(height: 6),
              _shadowTextField("Bathrooms", bathroomsController, number: true),
              const SizedBox(height: 12),
              _labelWithAsterisk("Land Area (m²)"),
              const SizedBox(height: 6),
              _shadowTextField(
                "Land Area (m²)",
                landAreaController,
                number: true,
              ),
              const SizedBox(height: 12),
              _labelWithAsterisk("Built-up Area (m²)"),
              const SizedBox(height: 6),
              _shadowTextField(
                "Built-up Area (m²)",
                builtUpAreaController,
                number: true,
              ),
              const SizedBox(height: 12),
              _labelWithAsterisk("Number of Floors"),
              const SizedBox(height: 6),
              _shadowTextField(
                "Number of F loors",
                numberOfFloorsController,
                number: true,
              ),
              const SizedBox(height: 12),
              _labelWithAsterisk("Has Garden?"),
              Row(
                children: [
                  Expanded(
                    child: _roundedChoice(
                      label: "Yes",
                      selected: hasGarden == true,
                      onTap: () => setState(() => hasGarden = true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _roundedChoice(
                      label: "No",
                      selected: hasGarden == false,
                      onTap: () => setState(() => hasGarden = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _labelWithAsterisk("Has Pool?"),
              Row(
                children: [
                  Expanded(
                    child: _roundedChoice(
                      label: "Yes",
                      selected: hasPool == true,
                      onTap: () => setState(() => hasPool = true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _roundedChoice(
                      label: "No",
                      selected: hasPool == false,
                      onTap: () => setState(() => hasPool = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text("Description (optional)", style: TextStyle(color: navy)),
              const SizedBox(height: 6),
              _shadowTextField(
                "Description",
                descriptionController,
                multi: true,
              ),
            ],

            if (selectedType == "Studio") ...[
              _labelWithAsterisk("Size (m²)"),
              const SizedBox(height: 6),
              _shadowTextField("Size (m²)", sizeController, number: true),
              const SizedBox(height: 12),
              _labelWithAsterisk("Furnished"),
              Row(
                children: [
                  Expanded(
                    child: _roundedChoice(
                      label: "Yes",
                      selected: furnished == true,
                      onTap: () => setState(() => furnished = true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _roundedChoice(
                      label: "No",
                      selected: furnished == false,
                      onTap: () => setState(() => furnished = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text("Description (optional)", style: TextStyle(color: navy)),
              const SizedBox(height: 6),
              _shadowTextField(
                "Description",
                descriptionController,
                multi: true,
              ),
            ],

            if (selectedType == "Penthouse") ...[
              _labelWithAsterisk("Bedrooms"),
              const SizedBox(height: 6),
              _shadowTextField("Bedrooms", bedroomsController, number: true),
              const SizedBox(height: 12),
              _labelWithAsterisk("Bathrooms"),
              const SizedBox(height: 6),
              _shadowTextField("Bathrooms", bathroomsController, number: true),
              const SizedBox(height: 12),
              _labelWithAsterisk("Size (m²)"),
              const SizedBox(height: 6),
              _shadowTextField("Size (m²)", sizeController, number: true),
              const SizedBox(height: 12),
              _labelWithAsterisk("Floor (must be top floors)"),
              const SizedBox(height: 6),
              _shadowTextField("Floor", floorController, number: true),
              const SizedBox(height: 12),
              _labelWithAsterisk("Has Terrace?"),
              Row(
                children: [
                  Expanded(
                    child: _roundedChoice(
                      label: "Yes",
                      selected: hasTerrace == true,
                      onTap: () => setState(() => hasTerrace = true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _roundedChoice(
                      label: "No",
                      selected: hasTerrace == false,
                      onTap: () => setState(() => hasTerrace = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text("Description (optional)", style: TextStyle(color: navy)),
              const SizedBox(height: 6),
              _shadowTextField(
                "Description",
                descriptionController,
                multi: true,
              ),
            ],

            const SizedBox(height: 12),

            // ElevatedButton(
            //   onPressed: () {
            //     _showRatingPopup();
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: navy,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(14),
            //     ),
            //     padding: const EdgeInsets.symmetric(vertical: 14),
            //     elevation: 6,
            //   ),
            //   child: Text(
            //     "Get a Rating",
            //     style: TextStyle(
            //       color: offWhite,
            //       backgroundColor: navy,
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            SizedBox(height: 30,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if(_validate()){
                    _showRatingPopup();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  "Find Rating",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ratedProperties.length,
              itemBuilder: (context, index) {
                final p = ratedProperties[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${p['type']} — ${p['city']}",
                        style: TextStyle(
                          color: navy,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Predicted Price: ${p['predictedPrice']}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      if (p['location'] != null)
                        Text("Location: ${p['location']}"),
                      if (p['bedrooms'] != null && p['bedrooms'].isNotEmpty)
                        Text("Bedrooms: ${p['bedrooms']}"),
                      if (p['bathrooms'] != null && p['bathrooms'].isNotEmpty)
                        Text("Bathrooms: ${p['bathrooms']}"),
                      if (p['size'] != null && p['size'].isNotEmpty)
                        Text("Size: ${p['size']} m²"),
                      if (p['floor'] != null && p['floor'].isNotEmpty)
                        Text("Floor: ${p['floor']}"),
                      if (p['furnished'] != null)
                        Text(
                          "Furnished: ${p['furnished'] == true ? "Yes" : "No"}",
                        ),
                      if (p['landArea'] != null && p['landArea'].isNotEmpty)
                        Text("Land Area: ${p['landArea']} m²"),
                      if (p['builtUpArea'] != null &&
                          p['builtUpArea'].isNotEmpty)
                        Text("Built-up Area: ${p['builtUpArea']} m²"),
                      if (p['numberOfFloors'] != null &&
                          p['numberOfFloors'].isNotEmpty)
                        Text("Number of Floors: ${p['numberOfFloors']}"),
                      if (p['hasGarden'] != null)
                        Text(
                          "Has Garden: ${p['hasGarden'] == true ? "Yes" : "No"}",
                        ),
                      if (p['hasPool'] != null)
                        Text(
                          "Has Pool: ${p['hasPool'] == true ? "Yes" : "No"}",
                        ),
                      if (p['hasTerrace'] != null)
                        Text(
                          "Has Terrace: ${p['hasTerrace'] == true ? "Yes" : "No"}",
                        ),
                      if (p['description'] != null &&
                          p['description'].isNotEmpty)
                        Text("Description: ${p['description']}"),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _labelWithAsterisk(String label) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(color: navy, fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 4),
        const Text(
          '*',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _shadowTextField(
    String hint,
    TextEditingController controller, {
    bool number = false,
    bool multi = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        maxLines: multi ? 4 : 1,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: navy.withOpacity(0.6)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  void _showRatingPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "Property Rating",
            style: TextStyle(color: navy, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Text(
                "Estimated Property Value:",
                style: TextStyle(fontSize: 16, color: navy),
              ),
              const SizedBox(height: 10),
              Text(
                "2,000,000 EGP",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: navy, fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: navy,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
              ),
              child: const Text(
                "Sell",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _roundedChoice({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: selected ? navy : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(color: navy.withOpacity(0.06)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(color: selected ? Colors.white : navy),
        ),
      ),
    );
  }
}

class CustomInlineDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;
  final String hint;
  final Color navy;
  final Color gold;

  const CustomInlineDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hint,
    required this.navy,
    required this.gold,
  });

  @override
  State<CustomInlineDropdown> createState() => _CustomInlineDropdownState();
}

class _CustomInlineDropdownState extends State<CustomInlineDropdown> {
  bool isOpen = false;
  int? hoverIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => isOpen = !isOpen),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.value ?? widget.hint,
                  style: TextStyle(
                    color: widget.value == null
                        ? widget.navy.withOpacity(0.6)
                        : widget.navy,
                    fontWeight: widget.value == null
                        ? FontWeight.w400
                        : FontWeight.w600,
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: widget.navy,
                ),
              ],
            ),
          ),
        ),

        if (isOpen)
          Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(14),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                final item = widget.items[index];
                final isHover = hoverIndex == index;

                return MouseRegion(
                  onEnter: (_) => setState(() => hoverIndex = index),
                  onExit: (_) => setState(() => hoverIndex = null),
                  child: GestureDetector(
                    onTap: () {
                      widget.onChanged(item);
                      setState(() => isOpen = false);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isHover ? widget.gold : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        item,
                        style: TextStyle(
                          color: isHover ? Colors.black : widget.navy,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
