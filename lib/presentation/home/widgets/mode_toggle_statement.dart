import 'package:flutter/material.dart';
import 'package:movin/app_theme.dart';
import 'package:movin/main.dart'; 
import 'package:movin/presentation/home/managers/mode_service.dart';
import '../../../data_injection/getIt/service_locator.dart';

class ModeToggleStatement extends StatefulWidget {  
  const ModeToggleStatement({super.key});

  @override
  State<ModeToggleStatement> createState() => _ModeToggleStatementState();
}

class _ModeToggleStatementState extends State<ModeToggleStatement> {
  bool _isSwitching = false;  

  void _toggleModeAndNavigate(BuildContext context) async {
    if (_isSwitching) return;  
    setState(() => _isSwitching = true);

    final modeService = getIt<ModeService>();

    
    final navigator = Navigator.of(context, rootNavigator: true);

    final wasSeller = modeService.isSellerNotifier.value;
    final newRole = wasSeller ? 'buyer' : 'seller';

    navigator.pop(); 

    try {
      final isNowSeller = await modeService.switchRole(newRole);

      navigator.pushNamedAndRemoveUntil(
        isNowSeller ? '/sellerhome' : '/buyerhome',
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          content: Text('Failed to switch role: $e'),
          backgroundColor: Colors.red,
        ),
      );
      if (mounted) setState(() => _isSwitching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GestureDetector(
        onTap: _isSwitching ? null : () => _toggleModeAndNavigate(context),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: _isSwitching
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.green,
                      ),
                    )
                  : const Icon(Icons.sync, color: Colors.green, size: 18),
            ),
            const SizedBox(width: 10),
            ValueListenableBuilder<bool>(
              valueListenable: getIt<ModeService>().isSellerNotifier,
              builder: (context, isSeller, _) {
                return Text(
                  _isSwitching
                      ? 'Switching...'
                      : isSeller
                          ? 'Switch to Buyer Mode'
                          : 'Switch to Seller Mode',
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