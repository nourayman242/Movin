import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Help & Support"),
        backgroundColor: AppColors.primaryNavy,
      ),
      body: const Center(
        child: Text(
          "Help & Support Page Content",
          style: TextStyle(fontSize: 18, color: AppColors.navyDark),
        ),
      ),
    );
  }
}
