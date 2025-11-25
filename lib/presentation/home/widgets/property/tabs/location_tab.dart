import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';

class LocationTab extends StatelessWidget {
  const LocationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 40.sp,
                color: AppColors.navyDark,
              ),
              SizedBox(height: 8.h),
              Text(
                'Interactive Map',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.navyDark,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Nisr City',
                style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _locationItem('Nearby Schools', 'Within 2 km'),
                  SizedBox(height: 14.h),
                  _locationItem('Metro Station', '5 min walk'),
                ],
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _locationItem('Shopping Malls', 'Within 3 km'),
                  SizedBox(height: 14.h),
                  _locationItem('Hospitals', 'Within 4 km'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _locationItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(fontSize: 14.sp, color: AppColors.primaryNavy),
        ),
      ],
    );
  }
}
