import 'package:flutter/material.dart';
import 'package:movin/presentation/home/managers/mode_service.dart';
import 'package:movin/presentation/home/screens/buyer_home_screen.dart';
import 'package:movin/presentation/seller_properties/saller%20home/seller_home_screen.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: ModeService.isSellerNotifier,
      builder: (context, isSeller, _) {
        return isSeller ? const SellerHome() : const BuyerHome();
      },
    );
  }
}
