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

    if (role != null) {
      // Already persisted from a previous session
      isSellerNotifier.value = role == 'seller';
    } else {
      // Fresh install — read from the saved user object
      final user = await SharedHelper.getUser();
      if (user != null) {
        final isSeller = user.isSeller ?? false;
        isSellerNotifier.value = isSeller;
        // Persist so next launch is correct
        await SharedHelper.setUserRole(isSeller ? 'seller' : 'buyer');
      }
    }
  }

  Future<bool> switchRole(String newRole) async {
    final response = await _repo.switchRole(newRole);

    final user = response.safeUser;
    final isSeller = user.isSeller ?? false;

    await SharedHelper.setUserRole(isSeller ? 'seller' : 'buyer');
    await SharedHelper.saveToken(response.accessToken);
    await SharedHelper.saveRefreshToken(response.refreshToken);
    await SharedHelper.saveUser(response.safeUser);

    isSellerNotifier.value = isSeller;

    return isSeller;
  }
}