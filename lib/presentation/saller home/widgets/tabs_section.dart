import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class TabsSection extends StatelessWidget {
  final TabController controller;
  const TabsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12),
        ],
      ),
      child: TabBar(
        controller: controller,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: AppColors.gold,
          borderRadius: BorderRadius.circular(18),
        ),
        labelColor: AppColors.primaryNavy,
        unselectedLabelColor: AppColors.navyDark,
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'My Listings'),
          Tab(text: 'News'),
        ],
      ),
    );
  }
}
