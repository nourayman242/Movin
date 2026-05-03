import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/data/models/profile_model.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';
import 'package:movin/presentation/login/cubit/reset_pass_cubit.dart';
import 'package:movin/presentation/login/screens/reset_password_page.dart';
import 'package:movin/presentation/profile/cubit/profile_cubit.dart';
import 'package:movin/presentation/profile/edit_profile_screen.dart';

class AccountSettingsCard extends StatelessWidget {
  final ProfileModel profile;
  const AccountSettingsCard({super.key, required this.profile});

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
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE5F1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline,
                    color: Color(0xFFD81B60),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Settings',
                      style: AppTextStyles.label.copyWith(
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Manage your account details',
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
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final updated = await Navigator.push<ProfileModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<ProfileCubit>(),
                      child: EditProfileScreen(profile: profile),
                    ),
                  ),
                );
                if (updated != null) {
                  context.read<ProfileCubit>().updateProfile(
                    username: updated.name,
                    bio: updated.bio,
                    location: updated.location,
                    phone: updated.phone,
                  );
                }
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () async {
                final email = await SharedHelper.getEmail();
                if (!context.mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => getIt<ResetPasswordCubit>(),
                      child: ResetPasswordPage(email: email ?? ''),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Manage Subscription'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}