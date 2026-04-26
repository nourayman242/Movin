import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/reset_pass_entity.dart';
import '../../../domain/repositories/reset_pass_repository.dart';
import '../api_services/reset_password_service.dart';
import '../models/reset_pass_dto.dart';

@LazySingleton(as: ResetPasswordRepository)
class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ResetPasswordService api;

  ResetPasswordRepositoryImpl(this.api);

  @override
  Future<String> resetPassword(ResetPasswordEntity entity) async {
    final dto = ResetPasswordDto.fromEntity(entity);
    try {
      final response = await api.resetPassword(dto);
      return response.message ?? "Password has been reset successfully";
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? e.message;
      throw Exception(msg);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}