// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ModeService {
//   static ValueNotifier<bool> isSellerNotifier = ValueNotifier(false);

//   static Future<void> loadUserMode() async {
//     final prefs = await SharedPreferences.getInstance();
//     isSellerNotifier.value = prefs.getBool('isSeller') ?? false;
//   }

//   static Future<void> toggleMode() async {
//     isSellerNotifier.value = !isSellerNotifier.value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isSeller', isSellerNotifier.value);
//   }
// }
import 'package:flutter/material.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

class ModeService {
  static ValueNotifier<bool> isSellerNotifier = ValueNotifier(false);

  static Future<void> loadUserMode() async {
    bool isSeller = await SharedHelper.getUserRole() == 'seller';
    isSellerNotifier.value = isSeller;
  }

  static Future<void> toggleMode() async {
    bool newMode = !isSellerNotifier.value;
    isSellerNotifier.value = newMode;

    await SharedHelper.setUserRole(newMode ? 'seller' : 'buyer');
  }
}

