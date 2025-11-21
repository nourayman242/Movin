abstract class OtpRepository {
  Future<void> verifyOtp({
    required String email,
    required String otp,
  });
}
