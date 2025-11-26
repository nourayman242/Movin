import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class SellerHome extends StatelessWidget {
  const SellerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: BackButton(
          color: AppColors.primaryNavy,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
        'Sallar Home',
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
          "Showing Seller Home Screen",
          style: const TextStyle(fontSize: 18, color: AppColors.navyDark),
        ),
      ),
    );
  }
}
