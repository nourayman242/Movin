
import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/home/managers/mode_service.dart';
import 'package:movin/presentation/profile/widget/custom_badge.dart';
import '../model/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;
  final VoidCallback onEdit;

  const ProfileHeader({super.key, required this.profile, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1F2A37), Color(0xFF111827)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const BackButton(color: Colors.white),
              const Spacer(),
              TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                label: const Text(
                  "Edit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryNavy,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: Center(
              child: Text(
                _initials(profile.name),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            profile.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 6),

          ValueListenableBuilder<bool>(
            valueListenable: ModeService.isSellerNotifier,
            builder: (context, isSeller, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BadgeCustomWidget(
                    icon: Icons.person_outline,
                    label: isSeller ? "Seller" : "Buyer",
                    isSeller: isSeller,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 12),

          Text(
            profile.bio,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(" ");
    if (parts.length >= 2) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : "";
  }
}
