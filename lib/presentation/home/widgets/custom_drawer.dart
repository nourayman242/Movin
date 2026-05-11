import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/data/models/profile_model.dart';
import 'package:movin/presentation/budget_calculator/screens/budget_calculator_screen.dart';
import 'package:movin/presentation/home/inner_pages/view_history_page.dart';
import 'package:movin/presentation/home/widgets/drawer_header.dart';
import 'package:movin/presentation/home/widgets/mode_toggle_statement.dart';
import 'package:movin/presentation/profile/cubit/profile_cubit.dart';
import 'package:movin/presentation/profile/profile_screen.dart';
import 'package:movin/presentation/settings/screens/settings_screen.dart';
import '../../help_support/screens/help_support.dart';
import '../../login/cubit/auth_cubit.dart';
import '../../property_evaluation/screens/property_evaluation_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.profile});
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
      child: Drawer(
        backgroundColor: AppColors.background,
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────
            GestureDetector(
              onTap: () {
                final cubit = context.read<ProfileCubit>();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: cubit,
                      child: const ProfileScreen(),
                    ),
                  ),
                );
              },
              child: CustomDrawerHeader(profile: profile),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(thickness: 1, color: Color(0xFFE8E8E8)),
            ),

            // ── Menu items ──────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DrawerTile(
                      icon: Icons.calculate_outlined,
                      label: 'Budget Calculator',
                      iconColor: const Color(0xFF5583D4),
                      onTap: () => _navigateTo(
                        context,
                        BudgetCalculatorScreen(),
                      ),
                    ),
                    _DrawerTile(
                      icon: Icons.star_outline_rounded,
                      label: 'Property Evaluations',
                      iconColor: Colors.amber,
                      onTap: () => _navigateTo(
                        context,
                        PropertyEvaluationScreen(),
                      ),
                    ),
                    if (profile.isBuyer)
                      _DrawerTile(
                        icon: Icons.history_rounded,
                        label: 'View History',
                        iconColor: const Color(0xFF696D73),
                        onTap: () =>
                            _navigateTo(context, const ViewHistoryPage()),
                      ),
                    _DrawerTile(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      iconColor: AppColors.navyLight,
                      onTap: () => _navigateTo(
                        context,
                        SettingsScreen(currentProfile: profile),
                      ),
                    ),
                    _DrawerTile(
                      icon: Icons.help_outline_rounded,
                      label: 'Help & Support',
                      iconColor: Colors.pinkAccent,
                      onTap: () =>
                          _navigateTo(context, HelpSupportScreen()),
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom section ──────────────────────────────────────
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(thickness: 1, color: Color(0xFFE8E8E8)),
            ),

            // Switch mode — green border container
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.green.withOpacity(0.35),
                  ),
                ),
                child: const ModeToggleStatement(),
              ),
            ),

            // Logout
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              child: _LogoutTile(
                onTap: () {
                  context.read<AuthCubit>().logout();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Logged out')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }
}

// ── Drawer Tile ───────────────────────────────────────────────────────────────
class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      splashColor: iconColor.withOpacity(0.08),
      highlightColor: iconColor.withOpacity(0.04),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.navyLight,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey[300],
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Logout Tile ───────────────────────────────────────────────────────────────
class _LogoutTile extends StatelessWidget {
  final VoidCallback onTap;
  const _LogoutTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      splashColor: AppColors.error.withOpacity(0.08),
      highlightColor: AppColors.error.withOpacity(0.04),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.error.withOpacity(0.06),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.error.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.logout_rounded,
                color: AppColors.error,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}