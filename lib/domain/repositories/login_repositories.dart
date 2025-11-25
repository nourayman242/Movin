import 'package:movin/data/api_services/login_response.dart';
import 'package:movin/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<LoginResponse> loginUser(LoginEntity user);
}