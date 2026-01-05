import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/budget_calculator/screens/budget_calculator_screen.dart';
import 'package:movin/presentation/home/inner_pages/rate_properties_page.dart';
import 'package:movin/presentation/home/inner_pages/settings_page.dart';
import 'package:movin/presentation/home/inner_pages/view_history_page.dart';
import 'package:movin/presentation/home/widgets/drawer_header.dart';
import 'package:movin/presentation/home/widgets/drawer_item.dart';
import 'package:movin/presentation/home/widgets/mode_toggle_statement.dart';
import 'package:movin/presentation/profile/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: Drawer(
        backgroundColor: AppColors.background,
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileScreen(),
                    ),
                  );
                },
              child: const CustomDrawerHeader()),
            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 178, 178, 180),
              height: 1,
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    DrawerItem(
                      icon: Icons.calculate_outlined,
                      text: 'Budget Calculator',
                      color: AppColors.navyLight,
                      iconColor: const Color.fromARGB(255, 85, 131, 212),
                      circleColor: const Color.fromARGB(
                        255,
                        85,
                        131,
                        212,
                      ).withOpacity(0.1),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BudgetCalculatorScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                    DrawerItem(
                      icon: Icons.star_outline,
                      text: 'Rate Properties',
                      iconColor: Colors.amber,
                      circleColor: Colors.amber.withOpacity(0.1),
                      color: AppColors.navyLight,
                      onTap: () =>
                          _navigateTo(context, const RatePropertiesPage()),
                    ),
                    SizedBox(height: 15),
                    // DrawerItem(
                    //   icon: Icons.person_outline,
                    //   text: 'Profile',
                    //   iconColor: Colors.pinkAccent,
                    //   circleColor: Colors.pinkAccent.withOpacity(0.1),
                    //   color: AppColors.navyLight,
                    //   onTap: () => _navigateTo(context, const ProfilePage()),
                    // ),
                    //SizedBox(height: 15),
                    DrawerItem(
                      icon: Icons.history_outlined,
                      text: 'View History',
                      color: AppColors.navyLight,
                      iconColor: const Color.fromARGB(255, 105, 109, 115),
                      circleColor: const Color.fromARGB(
                        255,
                        105,
                        109,
                        115,
                      ).withOpacity(0.1),
                      onTap: () =>
                          _navigateTo(context, const ViewHistoryPage()),
                    ),
                    SizedBox(height: 15),

                    DrawerItem(
                      icon: Icons.settings_outlined,
                      text: 'Settings',
                      color: AppColors.navyLight,
                      onTap: () => _navigateTo(context, const SettingsPage()),
                    ),
                    SizedBox(height: 15),
                    DrawerItem(
                      icon: Icons.help_outline,
                      text: 'Help & Support',
                      color: AppColors.navyLight,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),

            const Divider(
              thickness: 1,
              color: Color.fromARGB(255, 178, 178, 180),
              height: 1,
            ),
            SizedBox(height: 15),
            const ModeToggleStatement(),
            SizedBox(height: 15),
            DrawerItem(
              icon: Icons.logout_outlined,
              text: 'Logout',
              color: AppColors.error,
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Logged out')));
              },
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
