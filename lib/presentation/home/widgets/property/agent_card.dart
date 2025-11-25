import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/controllers/property_details_controller.dart';

class AgentCard extends StatefulWidget {
  final PropertyDetailsController controller;
  const AgentCard({super.key, required this.controller});

  @override
  State<AgentCard> createState() => _AgentCardState();
}

class _AgentCardState extends State<AgentCard> {
  bool isMessagePressed = false;
  bool isRatePressed = false;
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
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundColor: AppColors.primaryNavy,
            child: Text(
              'JS',
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text('John Smith', style: TextStyle(fontSize: 18.sp)),
          Text('Premium Agent', style: TextStyle(color: AppColors.grey)),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: AppColors.gold, size: 20.sp),
              Icon(Icons.star, color: AppColors.gold, size: 20.sp),
              Icon(Icons.star, color: AppColors.gold, size: 20.sp),
              Icon(Icons.star, color: AppColors.gold, size: 20.sp),
              Icon(Icons.star, color: AppColors.gold, size: 20.sp),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone, size: 18.sp),
              SizedBox(width: 6.w),
              Text('+971 50 123 4567'),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_outlined, size: 18.sp),
              SizedBox(width: 6.w),
              Text('Cairo, EGY'),
            ],
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryNavy,
              minimumSize: Size(double.infinity, 48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, size: 18.sp, color: AppColors.white),
                SizedBox(width: 10.w),
                const Text(
                  'Call Now',
                  style: TextStyle(color: AppColors.white),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          _pressableOutlined(
            isPressed: isMessagePressed,
            icon: Icons.message_outlined,
            text: 'Send Message',
            onTap: () {},
            onPressedChange: () {
              setState(() {
                isMessagePressed = !isMessagePressed;
                isRatePressed = false;
              });
            },
          ),
          SizedBox(height: 10.h),

          _pressableOutlined(
            isPressed: isRatePressed,
            icon: Icons.star_border_outlined,
            text: 'Rate Property',
            onTap: () {},
            onPressedChange: () {
              setState(() {
                isRatePressed = !isRatePressed;
                isMessagePressed = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _pressableOutlined({
    required bool isPressed,
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required VoidCallback onPressedChange,
  }) {
    return GestureDetector(
      onTapDown: (_) => onPressedChange(),
      onTap: onTap,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: isPressed ? AppColors.gold : AppColors.white,
          minimumSize: Size(double.infinity, 48.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.sp, color: AppColors.navyDark),
            SizedBox(width: 10.w),
            Text(text, style: TextStyle(color: AppColors.navyDark)),
          ],
        ),
      ),
    );
  }
}
