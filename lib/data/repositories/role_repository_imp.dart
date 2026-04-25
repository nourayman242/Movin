import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/role_services.dart';
import 'package:movin/data/models/role_dto.dart';
import 'package:movin/domain/repositories/role_repository.dart';
import 'package:movin/core/errors/error_handler.dart';

@LazySingleton(as: RoleRepository)
class RoleRepositoryImpl implements RoleRepository {
  final RoleServices service;
  RoleRepositoryImpl(this.service);

  @override
  Future<void> chooseRole(String role) async {
   // return service.chooseRole(RoleDto(role: role));
  try {
      await service.chooseRole(RoleDto(role: role));
    } catch (error) {
      final failure = ErrorHandler.handle(error);
      throw failure;
    }
  }
}
