
import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/profile/model/profile_model.dart';

class EditableContactInfoCard extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController locationController;

  const EditableContactInfoCard({
    super.key,
    required this.emailController,
    required this.phoneController,
    required this.locationController, required ProfileModel profile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Contact Information",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          _editableItem(Icons.email, "Email", emailController),
          _editableItem(Icons.phone, "Phone", phoneController, keyboardType: TextInputType.phone),
          _editableItem(Icons.location_on, "Location", locationController),

          _readOnlyItem(
            Icons.calendar_month,
            "Member Since",
            "January 2024",
          ),
        ],
      ),
    );
  }

  Widget _editableItem(
    IconData icon,
    String title,
    TextEditingController controller,
    {TextInputType? keyboardType}
  ) {
    return _cardWrapper(
      icon: icon,
      title: title,
      child: TextField(
        cursorColor: AppColors.primaryNavy,
        keyboardType: keyboardType,
        controller: controller,
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
        ),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _readOnlyItem(IconData icon, String title, String value) {
    return _cardWrapper(
      icon: icon,
      title: title,
      child: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _cardWrapper({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: AppColors.navyDark),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
