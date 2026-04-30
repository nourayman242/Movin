abstract class AuthRepository {
  Future<Map<String, dynamic>> loginWithGoogle();

  //logout
  Future<void> logout();
}