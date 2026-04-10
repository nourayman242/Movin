import 'package:movin/data/api_services/google_auth_service.dart';
import 'package:movin/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleAuthService service;

  AuthRepositoryImpl(this.service);

  @override
  Future<Map<String, dynamic>> loginWithGoogle() async {
    // final result = await service.signInWithGoogle();
    // return result["token"];
    return await service.signInWithGoogle();
  }
}