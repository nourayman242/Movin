import '../../data/models/verify_email_model.dart';

abstract class VerifyEmailRepository {
  Future<VerifyEmailResponse> verify(
      String email,
      String otp,
      );
  Future<String> resendOtp(String email);
}