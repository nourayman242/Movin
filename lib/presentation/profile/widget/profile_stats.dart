import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/models/profile_model.dart';
import 'package:movin/presentation/home/managers/mode_service.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key, required this.profile});
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final stats = profile.stats;
    
      return ValueListenableBuilder(
        valueListenable: ModeService.isSellerNotifier,
        builder: (context, isSeller, _) {
          if (isSeller) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatItem(
                    icon: Icons.home_work,
                    value: stats!["propertiesListed"],
                    label: "Properties Listed",
                  ),
                  _StatItem(
                    icon: Icons.star,
                    value: stats["totalViews"],
                    label: "Total Views",
                  ),
                  _StatItem(
                    icon: Icons.verified,
                    value: stats["successfulSales"],
                    label: "Successful Sales",
                  ),
                ],
              ),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _StatItem(
                  icon: Icons.gavel,
                  value: stats!["auctionParticipated"],
                  label: "Auction Participated",
                ),
              ],
            );
          }
        },
      );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final int? value;
  final String label;

  const _StatItem({
    required this.icon,
     this.value=0,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.gold, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            '$value',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
