
abstract class ForgotPasswordRepository {
  Future<void> sendOtp({required String email});

}
