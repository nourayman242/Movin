import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'edit_profile_screen.dart';
import 'model/profile_model.dart';
import 'package:movin/presentation/profile/widget/contact_info_card.dart';
import 'package:movin/presentation/profile/widget/profile_header.dart';
import 'package:movin/presentation/profile/widget/profile_stats.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileModel profile = ProfileModel(
    name: " Dr Mohammed",
    bio:
        "Passionate about real estate and finding the perfect home for my family.",
    email: "mohammed@gmail.com",
    phone: "+20 112 345 6789",
    location: "EGYPT, Cairo",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(
              profile: profile,
              onEdit: () async {
                final updated = await Navigator.push<ProfileModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(profile: profile),
                  ),
                );

                if (updated != null) {
                  setState(() => profile = updated);
                }
              },
            ),
            const SizedBox(height: 24),
            const ProfileStats(),
            const SizedBox(height: 32),
            EditableContactInfoCard(
              emailController: TextEditingController(text: profile.email),
              phoneController: TextEditingController(text: profile.phone),
              locationController: TextEditingController(text: profile.location),
              profile: profile,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
