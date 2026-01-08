import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class BadgeCustomWidget extends StatelessWidget {
  const BadgeCustomWidget({
    super.key,
    required this.icon,
    required this.label, required bool isSeller,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.navyDark),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.navyDark,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}