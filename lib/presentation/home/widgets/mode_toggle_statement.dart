import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/presentation/home/managers/mode_service.dart';

import '../../../data_injection/getIt/service_locator.dart';

class ModeToggleStatement extends StatelessWidget {
  const ModeToggleStatement({super.key});

  // void _toggleModeAndNavigate(BuildContext context) async {
  //   final safeContext = Navigator.of(context, rootNavigator: true).context;
  //   Navigator.pop(context);
  //   await Future.delayed(const Duration(milliseconds: 200));
  //   await ModeService.toggleMode();
  //   Navigator.pushReplacementNamed(safeContext, '/home');
  // }
  void _toggleModeAndNavigate(BuildContext context) async {
    final modeService = getIt<ModeService>();

    Navigator.pop(context);

    final isSeller = modeService.isSellerNotifier.value;

    await modeService.switchRole(
      isSeller ? 'buyer' : 'seller'
    );

    if (!context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      isSeller ? '/sellerhome' : '/buyerhome',
          (route) => false,
    );}
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GestureDetector(
        onTap: () => _toggleModeAndNavigate(context),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.sync, color: Colors.green, size: 18),
            ),
            const SizedBox(width: 10),
            ValueListenableBuilder<bool>(
              valueListenable: getIt<ModeService>().isSellerNotifier,
              builder: (context, isSeller, child) {
                final toggleText = isSeller
                    ? 'Switch to Buyer Mode'
                    : 'Switch to Seller Mode';
                return Text(
                  toggleText,
                  style: const TextStyle(
                    color: AppColors.navyLight,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
