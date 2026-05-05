import 'package:flutter/material.dart';

class PropertyTextField
    extends StatefulWidget {
  final TextEditingController controller;

  final String hint;

  final bool number;

  const PropertyTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.number = false,
  });

  @override
  State<PropertyTextField> createState() =>
      _PropertyTextFieldState();
}

class _PropertyTextFieldState
    extends State<PropertyTextField> {
  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 250,
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

            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Focus(
        onFocusChange: (value) {
          setState(() {
            focused = value;
          });
        },

        child: TextField(
          controller: widget.controller,

          keyboardType:
          widget.number
              ? TextInputType.number
              : TextInputType.text,

          decoration: InputDecoration(
            hintText: widget.hint,

            border: InputBorder.none,

            contentPadding:
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
          ),
        ),
      ),
    );
  }
}