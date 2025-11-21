import '../entities/reset_pass_entity.dart';

abstract class ResetPasswordRepository {
  Future<void> resetPassword(ResetPasswordEntity entity);
}
