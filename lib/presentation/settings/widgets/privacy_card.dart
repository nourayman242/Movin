import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';

class PrivacyLegalCard extends StatelessWidget {
  const PrivacyLegalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium + 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    color: Color(0xFF616161),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy & Legal',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Manage privacy and legal settings',
                      style: AppTextStyles.smallText.copyWith(
                        color: AppColors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            AppWidgets.verticalSpace(8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Terms of Service'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Data Management'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
