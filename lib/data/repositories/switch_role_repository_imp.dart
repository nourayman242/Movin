import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/switch_role_service.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/domain/repositories/switch_role_repository.dart';

import '../api_services/role_selection_response.dart';

@LazySingleton(as: SwitchRoleRepository)
class SwitchRoleRepositoryImpl implements SwitchRoleRepository {
  final SwitchRoleService service;

  SwitchRoleRepositoryImpl(this.service);

  @override
  Future<ChooseRoleResponse> switchRole(String newRole) async {
    final response = await service.switchRole({
      'newRole': newRole,
    });

    // persist session
    await SharedHelper.saveToken(response.accessToken);
    await SharedHelper.saveRefreshToken(response.refreshToken);
    await SharedHelper.setUserRole(newRole);
    await SharedHelper.setLoggedIn(true);

    return response;
  }
}