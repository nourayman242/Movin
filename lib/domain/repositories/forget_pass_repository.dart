abstract class ForgotPasswordRepository {
  Future<String> sendOtp({required String email}); // ← return String not void
}