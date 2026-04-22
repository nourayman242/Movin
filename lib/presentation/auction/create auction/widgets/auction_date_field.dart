import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuctionDateField extends StatelessWidget {
  final String label;
  final String hint;
  final String subtitle;

  const AuctionDateField({
    super.key,
    required this.label,
    required this.hint,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$label *"),
        SizedBox(height: 6.h),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: const Icon(Icons.calendar_today),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(subtitle, style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
      ],
    );
  }
}