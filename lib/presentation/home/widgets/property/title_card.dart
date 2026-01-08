import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/controllers/property_details_controller.dart';

class TitleCard extends StatelessWidget {
  final PropertyDetailsController controller;
  const TitleCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryNavy,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'For Sale',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Icon(Icons.star, color: AppColors.gold, size: 20.sp),
              SizedBox(width: 4.w),
              Text('4.8 (24 reviews)', style: TextStyle(fontSize: 14.sp)),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Modern Luxury Villa',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryNavy,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 18.sp,
                color: AppColors.grey,
              ),
              SizedBox(width: 4.w),
              Text('Nisr City', style: TextStyle(color: AppColors.grey)),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoItem(Icons.bed_outlined, '4', 'Bedrooms'),
              _infoItem(Icons.bathtub_outlined, '3', 'Bathrooms'),
              _infoItem(Icons.square_outlined, '3,500', 'M Sq'),
              _infoItem(
                Icons.gavel_outlined,
                'Mazad',
                'Auction',
                color: AppColors.gold,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String value, String label, {Color? color}) {
    return Column(
      children: [
        Icon(icon, size: 26.sp, color: color),
        SizedBox(height: 4.h),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
        ),
      ],
    );
  }
}
