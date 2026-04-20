import 'package:movin/data/api_services/role_services.dart';
import 'package:movin/data/models/role_dto.dart';
import 'package:movin/domain/repositories/role_repository.dart';

class RoleRepositoryImpl implements RoleRepository {
  final RoleServices service;
  RoleRepositoryImpl(this.service);

  @override
  Future<void> chooseRole(String role) {
    return service.chooseRole(RoleDto(role: role));
  }
}
