import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/google_auth_service.dart';
import 'package:movin/domain/repositories/auth_repository.dart';


import '../api_services/logout_services.dart';
import '../models/google_auth_response_model.dart';
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final GoogleAuthService googleService;
  final LogoutService logoutService;

  AuthRepositoryImpl(this.googleService, this.logoutService);

  @override
  Future<Map<String, dynamic>> loginWithGoogle() async {

    final result = await googleService.signInWithGoogle();

    if (result["accessToken"] == null) {
      throw Exception("Google login failed");
    }

    return result;
  }
  @override
  Future<void> logout() async {
    await logoutService.logout();
  }
}