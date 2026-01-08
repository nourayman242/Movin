import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/home/managers/mode_service.dart';

class CustomDrawerHeader extends StatefulWidget {
  const CustomDrawerHeader({super.key});

  @override
  State<CustomDrawerHeader> createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  @override
  void initState() {
    super.initState();
    ModeService.loadUserMode();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: AppColors.primaryNavy,
            child: const Text(
              'JD',
              style: TextStyle(
                color: Color.fromARGB(255, 241, 242, 245),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ValueListenableBuilder<bool>(
              valueListenable: ModeService.isSellerNotifier,
              builder: (context, isSeller, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: AppTextStyles.subHeading.copyWith(
                        color: AppColors.navyDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'john.doe@example.com',
                      style: TextStyle(color: AppColors.navyDark, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSeller
                            ? Colors.amber.withOpacity(0.3)
                            : Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isSeller ? 'Seller' : 'Buyer',
                        style: TextStyle(
                          color: isSeller
                              ? Colors.amber.withOpacity(0.9)
                              : Colors.blue.withOpacity(0.9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

