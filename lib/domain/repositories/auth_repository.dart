import 'package:movin/data/api_services/google_auth_response.dart';

abstract class AuthRepository {
  Future<GoogleAuthResponse> loginWithGoogle();
}