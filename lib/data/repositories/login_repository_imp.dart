

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/login_services.dart';
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
    print('Login DTO: ${dto.toJson()}');

    try {
      final response = await api.loginUser(dto);
      print("LOGIN SUCCESS: ${response.toJson()}");

      return response;

    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? e.message;
      print("LOGIN ERROR: $msg");
      throw Exception(msg);

    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
