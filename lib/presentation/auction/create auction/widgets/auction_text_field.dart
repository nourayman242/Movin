
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuctionTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final String? subtitle;
  final String? prefix;
  final int maxLines;
  final TextEditingController? controller;

  const AuctionTextField({
    super.key,
    this.label,
    required this.hint,
    this.subtitle,
    this.prefix,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text("$label *"),
        SizedBox(height: 6.h),
        TextField(
          keyboardType: TextInputType.number,
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixText: prefix,
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              subtitle!,
              style: TextStyle(fontSize: 11.sp, color: Colors.grey),
            ),
          ),
      ],
    );
  }
}