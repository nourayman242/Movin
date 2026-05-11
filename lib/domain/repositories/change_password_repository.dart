import '../entities/change_password_entity.dart';

abstract class ChangePasswordRepository {
  Future<String> changePassword(ChangePasswordEntity entity);
}