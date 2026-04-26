abstract class OtpRepository {
  Future<String> verifyOtp({required String email, required String otp});
}
