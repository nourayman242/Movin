import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color? iconColor;
  final Color? circleColor;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.color = AppColors.navyLight,
    this.iconColor,
    this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    final iconCol = iconColor ?? color;
    final circleCol = circleColor ?? color.withOpacity(0.1);

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: circleCol, shape: BoxShape.circle),
        child: Icon(icon, color: iconCol),
      ),
      title: Text(text, style: AppTextStyles.label.copyWith(color: color)),
      onTap: onTap,
    );
  }
}
