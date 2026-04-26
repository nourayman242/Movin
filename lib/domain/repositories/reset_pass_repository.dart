import '../entities/reset_pass_entity.dart';

abstract class ResetPasswordRepository {
  Future<String> resetPassword(ResetPasswordEntity entity); // ← String not void
}