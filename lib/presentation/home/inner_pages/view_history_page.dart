import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class ViewHistoryPage extends StatelessWidget {
  const ViewHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("View History"),
        backgroundColor: AppColors.primaryNavy,
      ),
      body: const Center(
        child: Text(
          "View History Page Content",
          style: TextStyle(fontSize: 18, color: AppColors.navyDark),
        ),
      ),
    );
  }
}
