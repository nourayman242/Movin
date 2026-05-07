import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/repositories/verify_email_repository.dart';
import '../api_services/verify_email_service.dart';
import '../models/verify_email_model.dart';

@LazySingleton(as: VerifyEmailRepository)
class VerifyEmailRepositoryImpl implements VerifyEmailRepository {
  final VerifyEmailService api;

  VerifyEmailRepositoryImpl(this.api);

  @override
  Future<VerifyEmailResponse> verify(
      String email,
      String otp,
      ) async {
    try {
      final res = await api.verifyEmail({
        "email": email,
        "otp": otp,
      });

      return res;

    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? 'OTP failed';
      throw Exception(message);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  @override
  Future<String> resendOtp(String email) async {
    try {

      final res = await api.resendOtp({
        "email": email,
      });

      return res.message;

    } on DioException catch (e) {

      final message =
          e.response?.data?['message'] ??
              'Failed to resend OTP';

      throw Exception(message);

    } catch (e) {

      throw Exception('Unexpected error: $e');
    }
  }
}