import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/presentation/controllers/property_details_controller.dart';

import 'features_tab.dart';
import 'location_tab.dart';
import 'description_tab.dart';
import 'package:movin/app_theme.dart';

class PropertyTabs extends StatelessWidget {
  final PropertyDetailsController controller;
  const PropertyTabs({super.key, required this.controller});

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
              _tabItem('Description', 0),
              SizedBox(width: 10.w),
              _tabItem('Features', 1),
              SizedBox(width: 10.w),
              _tabItem('Location', 2),
            ],
          ),
          SizedBox(height: 20.h),
          if (controller.selectedTab == 0)
            DescriptionTab()
          else if (controller.selectedTab == 1)
            FeaturesTab()
          else
            LocationTab(),
        ],
      ),
    );
  }

  Widget _tabItem(String title, int index) {
    final active = controller.selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectTab(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: active ? AppColors.primaryNavy : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(30.r),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: active ? AppColors.white : AppColors.primaryNavy,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
