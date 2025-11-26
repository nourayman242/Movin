import 'package:flutter/material.dart';

class RatePropertiesPage extends StatefulWidget {
  const RatePropertiesPage({super.key});

  @override
  State<RatePropertiesPage> createState() => _RatePropertiesPageState();
}

class _RatePropertiesPageState extends State<RatePropertiesPage> {
  // Colors
  final Color navy = const Color(0xFF001F3F);
  final Color offWhite = const Color(0xFFF8F8F8);
  final Color gold = const Color(0xFFFFD700);

  // Stored properties
  List<Map<String, dynamic>> ratedProperties = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: offWhite,
      appBar: AppBar(
        backgroundColor: navy,
        title: const Text("Rate Properties"),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ratedProperties.isEmpty ? _emptyState() : _propertiesList(),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Rated Properties,\nclick + to rate your property",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: navy,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _openAddPropertyDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: navy,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
            ),
            child: const Text("+ Add Property", style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Widget _propertiesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ratedProperties.length + 1, // last item is the Add button
      itemBuilder: (context, index) {
        if (index == ratedProperties.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: ElevatedButton(
                onPressed: _openAddPropertyDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: navy,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                ),
                child:
                    const Text("+ Add Property", style: TextStyle(fontSize: 18)),
              ),
            ),
          );
        }

        final p = ratedProperties[index];
        return Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Price on the same row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "${p['type']} — ${p['city']}",
                        style: TextStyle(
                          color: navy,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      p['predictedPrice'],
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                _cardInfo("Location", p['location']),
                _cardInfo("Bedrooms", p['bedrooms']),
                _cardInfo("Bathrooms", p['bathrooms']),
                _cardInfo("Size", "${p['size']} m²"),
                _cardInfo("Floor", p['floor']),
                _cardInfo("Furnished", p['furnished'] == true ? "Yes" : "No"),
                if (p['description'] != null && p['description'].isNotEmpty)
                  _cardInfo("Description", p['description']),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _cardInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        "$label: $value",
        style: TextStyle(color: navy, fontSize: 14),
      ),
    );
  }

  // ---------------- DIALOG ----------------
  void _openAddPropertyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddPropertyDialog(
        navy: navy,
        offWhite: offWhite,
        gold: gold,
        onComplete: (propertyData) {
          setState(() {
            ratedProperties.add(propertyData);
          });
          Navigator.pop(context); // close dialog
        },
      ),
    );
  }
}

// ====================== ADD PROPERTY DIALOG ======================
class AddPropertyDialog extends StatefulWidget {
  final Color navy;
  final Color offWhite;
  final Color gold;
  final void Function(Map<String, dynamic>) onComplete;

  const AddPropertyDialog({
    super.key,
    required this.navy,
    required this.offWhite,
    required this.gold,
    required this.onComplete,
  });

  @override
  State<AddPropertyDialog> createState() => _AddPropertyDialogState();
}

class _AddPropertyDialogState extends State<AddPropertyDialog> {
  late final Color navy;
  late final Color offWhite;
  late final Color gold;

  // controllers
  final TextEditingController cityController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController bedroomsController = TextEditingController();
  final TextEditingController bathroomsController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // dropdown selection
  String? selectedType;
  bool? furnished;

  // property type options
  final List<String> propertyTypes = [
    "Apartment",
    "Villa",
    "Studio",
    "Penthouse"
  ];

  @override
  void initState() {
    super.initState();
    navy = widget.navy;
    offWhite = widget.offWhite;
    gold = widget.gold;
  }

  // validate required fields (all except description)
  bool _validate() {
    if (selectedType == null ||
        cityController.text.trim().isEmpty ||
        locationController.text.trim().isEmpty ||
        bedroomsController.text.trim().isEmpty ||
        bathroomsController.text.trim().isEmpty ||
        sizeController.text.trim().isEmpty ||
        floorController.text.trim().isEmpty ||
        furnished == null) {
      _showMissingAlert();
      return false;
    }
    return true;
  }

  void _showMissingAlert() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: offWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: navy),
            const SizedBox(width: 8),
            Text("Missing Fields", style: TextStyle(color: navy)),
          ],
        ),
        content: Text("⚠️ Please fill all required fields.",
            style: TextStyle(color: navy)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("OK", style: TextStyle(color: navy)),
          )
        ],
      ),
    );
  }

  // finish and return data to parent
  void _finish() {
    if (!_validate()) return;

    final property = {
      "type": selectedType!,
      "city": cityController.text.trim(),
      "location": locationController.text.trim(),
      "bedrooms": bedroomsController.text.trim(),
      "bathrooms": bathroomsController.text.trim(),
      "size": sizeController.text.trim(),
      "floor": floorController.text.trim(),
      "furnished": furnished,
      "description": descriptionController.text.trim(),
      // price shown on main page card
      "predictedPrice": "2,000,000 EGP",
    };

    widget.onComplete(property);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      backgroundColor: offWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: SizedBox(
        height: 640,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              // header + subtitle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rate Property",
                        style: TextStyle(
                            color: navy,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Help Others By Rating Properties",
                        style: TextStyle(color: navy.withOpacity(0.8)),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: navy),
                    tooltip: "Close",
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Property Type dropdown (custom with hover gold)
                      _labelWithAsterisk("Property Type"),
                      const SizedBox(height: 6),
                      _CustomHoverDropdown(
                        items: propertyTypes,
                        value: selectedType,
                        navy: navy,
                        gold: gold,
                        offWhite: offWhite,
                        hint: "Select property type",
                        onChanged: (v) => setState(() => selectedType = v),
                      ),

                      const SizedBox(height: 12),

                      // City
                      _labelWithAsterisk("City"),
                      const SizedBox(height: 6),
                      _shadowTextField("City", cityController),

                      const SizedBox(height: 12),

                      // Location / Area
                      _labelWithAsterisk("Location / Area"),
                      const SizedBox(height: 6),
                      _shadowTextField("Location / Area", locationController),

                      const SizedBox(height: 12),

                      // Bedrooms / Bathrooms / Size / Floor (grouped)
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _labelWithAsterisk("Bedrooms"),
                                const SizedBox(height: 6),
                                _shadowTextField(
                                    "Bedrooms", bedroomsController,
                                    number: true),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _labelWithAsterisk("Bathrooms"),
                                const SizedBox(height: 6),
                                _shadowTextField(
                                    "Bathrooms", bathroomsController,
                                    number: true),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _labelWithAsterisk("Size (m²)"),
                                const SizedBox(height: 6),
                                _shadowTextField("Size (m²)", sizeController,
                                    number: true),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _labelWithAsterisk("Floor"),
                                const SizedBox(height: 6),
                                _shadowTextField("Floor", floorController,
                                    number: true),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Furnished
                      _labelWithAsterisk("Furnished"),
                      Row(
                        children: [
                          Expanded(
                            child: _roundedChoice(
                                label: "Yes",
                                selected: furnished == true,
                                onTap: () => setState(() => furnished = true)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _roundedChoice(
                                label: "No",
                                selected: furnished == false,
                                onTap: () => setState(() => furnished = false)),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Description (optional)
                      Text(
                        "Description (optional)",
                        style: TextStyle(color: navy),
                      ),
                      const SizedBox(height: 6),
                      _shadowTextField("Description", descriptionController,
                          multi: true),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: navy),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text("Cancel", style: TextStyle(color: navy)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _finish,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: navy,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 6,
                      ),
                      child: const Text("Finish",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // small helper to show label with red asterisk after label (Option A)
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
        )
      ],
    );
  }

  // rounded shadowed textfield (no visible border)
  Widget _shadowTextField(String hint, TextEditingController controller,
      {bool number = false, bool multi = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
    );
  }

  // rounded choice pill
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
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
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

// ================= Custom dropdown that supports hover color =================
class _CustomHoverDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final void Function(String?) onChanged;
  final String hint;
  final Color navy;
  final Color gold;
  final Color offWhite;

  const _CustomHoverDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    required this.hint,
    required this.navy,
    required this.gold,
    required this.offWhite,
  });

  @override
  State<_CustomHoverDropdown> createState() => _CustomHoverDropdownState();
}

class _CustomHoverDropdownState extends State<_CustomHoverDropdown> {
  int? _hoverIndex;

  void _openMenu() async {
    // Use showDialog to present a rounded list where we can do hover styling.
    final selected = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: widget.offWhite,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300, maxWidth: 340),
            child: StatefulBuilder(builder: (contextSB, setStateSB) {
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: widget.items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context2, i) {
                  final item = widget.items[i];
                  final isHover = _hoverIndex == i;
                  return MouseRegion(
                    onEnter: (_) => setStateSB(() => _hoverIndex = i),
                    onExit: (_) => setStateSB(() => _hoverIndex = null),
                    child: GestureDetector(
                      onTap: () => Navigator.of(ctx).pop(item),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isHover ? widget.gold : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3))
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
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
              );
            }),
          ),
        );
      },
    );

    if (selected != null) {
      widget.onChanged(selected);
    }
    setState(() => _hoverIndex = null);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openMenu,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
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
                fontWeight: widget.value == null ? FontWeight.w400 : FontWeight.w600,
              ),
            ),
            Icon(Icons.keyboard_arrow_down, color: widget.navy),
          ],
        ),
      ),
    );
  }
}
