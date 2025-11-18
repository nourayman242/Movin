import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

Widget iconContainer(IconData icon, {bool hasBadge = false}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.navyLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white),
      ),
      if (hasBadge)
        Positioned(
          top: 5,
          right: 5,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.gold,
              shape: BoxShape.circle,
            ),
          ),
        ),
    ],
  );
}
