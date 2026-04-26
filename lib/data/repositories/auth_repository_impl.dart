import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/google_auth_response.dart';
import 'package:movin/data/api_services/google_auth_service.dart';
import 'package:movin/domain/repositories/auth_repository.dart';
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final GoogleAuthService service;

  AuthRepositoryImpl(this.service);

  @override
  Future<GoogleAuthResponse> loginWithGoogle() {
  return service.signInWithGoogle();
}
}