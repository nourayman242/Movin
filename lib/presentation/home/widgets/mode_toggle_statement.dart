import 'package:flutter/material.dart';
import 'package:movin/presentation/home/managers/mode_service.dart';

class ModeToggleStatement extends StatelessWidget {
  const ModeToggleStatement({super.key});

 void _toggleModeAndNavigate(BuildContext context) async {
  final safeContext = Navigator.of(context, rootNavigator: true).context;
  Navigator.pop(context);
  await Future.delayed(const Duration(milliseconds: 200));
  await ModeService.toggleMode();
  Navigator.pushReplacementNamed(safeContext, '/home');
}


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GestureDetector(
        onTap: () => _toggleModeAndNavigate(context),
        child: Row(
          children: [
            const Icon(Icons.sync, color: Colors.green),
            const SizedBox(width: 10),
            ValueListenableBuilder<bool>(
              valueListenable: ModeService.isSellerNotifier,
              builder: (context, isSeller, child) {
                final toggleText = isSeller
                    ? 'Switch to Buyer Mode'
                    : 'Switch to Seller Mode';
                return Text(
                  toggleText,
                  style: const TextStyle(
                    color: Colors.green,
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
