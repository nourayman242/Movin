import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

Widget buildPlaceholderPage(BuildContext context, String title) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      backgroundColor: AppColors.primaryNavy,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    backgroundColor: AppColors.background,
    body: Center(child: Text(title, style: AppTextStyles.heading)),
  );
}
