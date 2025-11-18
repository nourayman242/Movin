import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class RatePropertiesPage extends StatelessWidget {
  const RatePropertiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Rate Properties"),
        backgroundColor: Colors.amber,
      ),
      body: const Center(
        child: Text(
          "Rate Properties Page Content",
          style: TextStyle(fontSize: 18, color: AppColors.navyDark),
        ),
      ),
    );
  }
}
