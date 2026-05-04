import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/role_services.dart';
import 'package:movin/data/models/role_dto.dart';
import 'package:movin/domain/repositories/role_repository.dart';
import 'package:movin/core/errors/error_handler.dart';

import '../api_services/role_selection_response.dart';

@LazySingleton(as: RoleRepository)
class RoleRepositoryImpl implements RoleRepository {
  final RoleServices service;
  RoleRepositoryImpl(this.service);

  @override
  Future<ChooseRoleResponse> chooseRole(String role) async {
   // return service.chooseRole(RoleDto(role: role));
  try {
      final response=service.chooseRole(RoleDto(role: role));
      return response;
    } catch (error) {
      final failure = ErrorHandler.handle(error);
      throw failure;
    }
  }
}
