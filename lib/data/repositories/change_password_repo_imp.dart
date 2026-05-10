import 'package:injectable/injectable.dart';
import 'package:movin/domain/entities/change_password_entity.dart';
import 'package:movin/domain/repositories/change_password_repository.dart';
import '../api_services/change_password_service.dart';
import '../models/change_password_dto.dart';

@LazySingleton(as: ChangePasswordRepository)
class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final ChangePasswordService _service;

  ChangePasswordRepositoryImpl(this._service);

  @override
  Future<String> changePassword(ChangePasswordEntity entity) async {
    final dto = ChangePasswordDto(
      oldPassword: entity.oldPassword,
      newPassword: entity.newPassword,
    );
    final response = await _service.changePassword(dto);
    return response.message ?? "Password changed successfully";
  }
}