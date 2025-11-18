import 'package:flutter/material.dart';
import 'package:movin/presentation/home/managers/mode_service.dart';

class ModeToggleStatement extends StatelessWidget {
  const ModeToggleStatement({super.key});

  void _toggleMode(BuildContext context) async {
    await ModeService.toggleMode();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ModeService.isSellerNotifier.value
              ? 'Switched to Seller mode'
              : 'Switched to Buyer mode',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: GestureDetector(
        onTap: () => _toggleMode(context),
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
