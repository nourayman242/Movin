import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/home/managers/mode_service.dart';
import 'package:movin/presentation/profile/widget/contact_info_card.dart';
import 'package:movin/presentation/profile/widget/custom_badge.dart';
import 'model/profile_model.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileModel profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController bioCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController locationCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.profile.name);
    bioCtrl = TextEditingController(text: widget.profile.bio);
    emailCtrl = TextEditingController(text: widget.profile.email);
    phoneCtrl = TextEditingController(text: widget.profile.phone);
    locationCtrl = TextEditingController(text: widget.profile.location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 6),

            const SizedBox(height: 16),

            _editableName(),

            _editableBio(),

            const SizedBox(height: 24),

            EditableContactInfoCard(
              emailController: emailCtrl,
              phoneController: phoneCtrl,
              locationController: locationCtrl,
              profile: widget.profile,
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1F2A37), Color(0xFF111827)],
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
                  backgroundColor: AppColors.grey.withOpacity(0.25),
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: _save,
                icon: const Icon(Icons.save, size: 18),
                label: const Text("Save"),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Stack(
            children: [
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: nameCtrl,
                builder: (context, value, _) {
                  return CircleAvatar(
                    radius: 48,
                    backgroundColor: AppColors.white,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: AppColors.primaryNavy,
                      child: Text(
                        _initials(value.text),
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),

              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.gold,
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
        ],
      ),
    );
  }

  Widget _editableName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        cursorColor: AppColors.primaryNavy,
        controller: nameCtrl,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _editableBio() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        cursorColor: AppColors.primaryNavy,
        controller: bioCtrl,
        maxLines: 3,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _save() {
    Navigator.pop(
      context,
      widget.profile.copyWith(
        name: nameCtrl.text,
        bio: bioCtrl.text,
        email: emailCtrl.text,
        phone: phoneCtrl.text,
        location: locationCtrl.text,
      ),
    );
  }
}

String _initials(String name) {
  final parts = name.trim().split(" ");
  if (parts.length >= 2) {
    return "${parts[0][0]}${parts[1][0]}".toUpperCase();
  }
  return name.isNotEmpty ? name[0].toUpperCase() : "";
}
