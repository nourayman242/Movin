import 'package:flutter/material.dart';

class PropertyDropdown
    extends StatefulWidget {
  final List<String> items;

  final String? value;

  final String hint;

  final Function(String?) onChanged;

  const PropertyDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.hint,
    required this.onChanged,
  });

  @override
  State<PropertyDropdown> createState() =>
      _PropertyDropdownState();
}

class _PropertyDropdownState
    extends State<PropertyDropdown> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 250,
      ),

      padding:
      const EdgeInsets.symmetric(
        horizontal: 18,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(22),

        border: Border.all(
          color:
          focused
              ? const Color(0xFFD4AF37)
              : Colors.transparent,

          width: 1.4,
        ),

        boxShadow: [
          BoxShadow(
            color:
            focused
                ? const Color(0xFFD4AF37)
                .withOpacity(0.15)
                : Colors.black12,

            blurRadius: focused ? 18 : 8,
          ),
        ],
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: widget.value,

          hint: Text(widget.hint),

          isExpanded: true,
          dropdownColor: Colors.white,

          items:
          widget.items.map((e) {
            return DropdownMenuItem(
              value: e,

              child: Text(e),
            );
          }).toList(),

          onTap: () {
            setState(() {
              focused = true;
            });
          },

          onChanged: (value) {
            widget.onChanged(value);

            setState(() {
              focused = false;
            });
          },
        ),
      ),
    );
  }
}