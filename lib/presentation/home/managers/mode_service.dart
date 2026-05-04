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
// import 'package:flutter/material.dart';
// import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
//
// class ModeService {
//   static ValueNotifier<bool> isSellerNotifier = ValueNotifier(false);
//
//   static Future<void> loadUserMode() async {
//     bool isSeller = await SharedHelper.getUserRole() == 'seller';
//     isSellerNotifier.value = isSeller;
//   }
//
//   static Future<void> toggleMode() async {
//     bool newMode = !isSellerNotifier.value;
//     isSellerNotifier.value = newMode;
//
//     await SharedHelper.setUserRole(newMode ? 'seller' : 'buyer');
//   }
// }
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/domain/repositories/switch_role_repository.dart';

@lazySingleton
class ModeService {
  final SwitchRoleRepository _repo;

  ModeService(this._repo);

  final ValueNotifier<bool> isSellerNotifier = ValueNotifier(false);

  Future<void> loadUserMode() async {
    final role = await SharedHelper.getUserRole();
    isSellerNotifier.value = role == 'seller';
  }

  // Future<void> switchRole(String newRole) async {
  //   final response = await _repo.switchRole(newRole);
  //
  //   //
  //  // await SharedHelper.setUserRole(response.role); // لو موجودة
  //  //  await SharedHelper.saveToken(response.accessToken);
  //  //  await SharedHelper.saveRefreshToken(response.refreshToken);
  //
  //   isSellerNotifier.value = response.role == 'seller'
  //       //newRole == 'seller';
  // }
  // Future<void> switchRole(String newRole) async {
  //   await _repo.switchRole(newRole);
  //
  //   // update local storage
  //   await SharedHelper.setUserRole(newRole);
  //
  //   // update UI state
  //   isSellerNotifier.value = newRole == 'seller';
  // }
  // Future<void> switchRole(String newRole) async {
  //   final response = await _repo.switchRole(newRole);
  //
  //   final user = response.safeUser;
  //
  //   final isSeller = user.isSeller ?? false;
  //
  //   await SharedHelper.setUserRole(
  //     isSeller ? 'seller' : 'buyer',
  //   );
  //
  //   await SharedHelper.saveToken(response.accessToken);
  //   await SharedHelper.saveRefreshToken(response.refreshToken);
  //
  //   isSellerNotifier.value = isSeller;
  // }
  Future<bool> switchRole(String newRole) async {
    final response = await _repo.switchRole(newRole);

    final user = response.safeUser;
    final isSeller = user.isSeller ?? false;

    await SharedHelper.setUserRole(isSeller ? 'seller' : 'buyer');
    await SharedHelper.saveToken(response.accessToken);
    await SharedHelper.saveRefreshToken(response.refreshToken);

    isSellerNotifier.value = isSeller;

    return isSeller;
  }
}