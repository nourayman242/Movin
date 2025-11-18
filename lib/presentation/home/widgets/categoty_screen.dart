import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryTitle;
  final String propertyCount;

  const CategoryScreen({
    super.key,
    required this.categoryTitle,
    required this.propertyCount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          categoryTitle,
          style: const TextStyle(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: AppColors.primaryNavy),
      ),
      body: Center(
        child: Text(
          "Showing $propertyCount properties in $categoryTitle",
          style: const TextStyle(fontSize: 18, color: AppColors.navyDark),
        ),
      ),
    );
  }
}
