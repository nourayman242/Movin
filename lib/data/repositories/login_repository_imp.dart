import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/login_services.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/data/models/login_dto.dart';
import 'package:movin/domain/entities/login_entity.dart';
import 'package:movin/domain/repositories/login_repositories.dart';
import 'package:movin/data/api_services/login_response.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginServices api;

  LoginRepositoryImpl(this.api);

  @override
  Future<LoginResponse> loginUser(LoginEntity user) async {
    final dto = LoginDto.fromEntity(user);

    try {
      final response = await api.loginUser(dto);

      if (response.accessToken.isEmpty) {
        throw Exception(response.message.isNotEmpty
            ? response.message
            : 'Invalid email or password');
      }

      await SharedHelper.saveToken(response.accessToken);
      await SharedHelper.saveRefreshToken(response.refreshToken);
      await SharedHelper.saveUser(response.user);
      await SharedHelper.setUserRole(
        response.user.isSeller == true ? 'seller' : 'buyer',
      );
      await SharedHelper.setLoggedIn(true);

      return response;

    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Login failed';
      throw Exception(msg);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}