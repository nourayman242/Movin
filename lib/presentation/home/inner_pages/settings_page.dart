import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: AppColors.primaryNavy,
      ),
      body: const Center(
        child: Text(
          "Settings Page Content",
          style: TextStyle(fontSize: 18, color: AppColors.navyDark),
        ),
      ),
    );
  }
}
