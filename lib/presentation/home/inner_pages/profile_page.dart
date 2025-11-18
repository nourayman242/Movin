import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: const Center(
        child: Text(
          "Profile Page Content",
          style: TextStyle(fontSize: 18, color: AppColors.navyDark),
        ),
      ),
    );
  }
}
