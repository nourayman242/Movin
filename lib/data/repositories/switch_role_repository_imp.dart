import 'package:dio/dio.dart';
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
    try {
      final response = await service.switchRole({'newRole': newRole});

      await SharedHelper.saveToken(response.accessToken);
      await SharedHelper.saveRefreshToken(response.refreshToken);
      await SharedHelper.saveUser(response.safeUser);       
      await SharedHelper.setUserRole(
        response.safeUser.isSeller == true ? 'seller' : 'buyer',
      );
      await SharedHelper.setLoggedIn(true);

      return response;
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? e.message;
      throw Exception(msg);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}