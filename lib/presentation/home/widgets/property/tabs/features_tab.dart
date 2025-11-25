import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';

class FeaturesTab extends StatelessWidget {
  const FeaturesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _featureRow("Private Pool", "Garden"),
        _featureRow("Parking (3 cars)", "Maid's Room"),
        _featureRow("Balcony", "Central AC"),
        _featureRow("Built-in Wardrobes", "Security System"),
        _featureRow("Smart Home", "Gym Access"),
      ],
    );
  }

  Widget _featureRow(String left, String right) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Expanded(child: _featureBox(left)),
          SizedBox(width: 12.w),
          Expanded(child: _featureBox(right)),
        ],
      ),
    );
  }

  Widget _featureBox(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.circle, size: 8.sp, color: AppColors.gold),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.navyDark,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
