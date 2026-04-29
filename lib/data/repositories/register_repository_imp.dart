// // lib/data/repositories/register_repository_impl.dart
// import 'package:dio/dio.dart';
// import 'package:injectable/injectable.dart';
// import 'package:movin/data/api_services/register_services.dart';
// import '../../domain/entities/register_entity.dart';
// import '../../domain/repositories/register_repository.dart';
// import '../models/register_dto.dart';
//
// @LazySingleton(as: RegisterRepository)
// class RegisterRepositoryImpl implements RegisterRepository {
//   final RegisterServices api;
//
//   RegisterRepositoryImpl(this.api);
//
//   @override
//   Future<void> registerUser(RegisterEntity user) async {
//     final dto = RegisterDto.fromEntity(user);
//     print('Register DTO: ${dto.toJson()}');
//     try {
//       final response = await api.registerUser(dto);
//       return;
//     } on DioError catch (e) {
//       final msg = e.response?.data?['message'] ?? e.message;
//       throw Exception(msg);
//     } catch (e) {
//       throw Exception('Unexpected error: $e');
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/register_services.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/repositories/register_repository.dart';
import '../models/register_dto.dart';
import '../api_services/register_response.dart';

@LazySingleton(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterServices api;

  RegisterRepositoryImpl(this.api);

  @override
  Future<RegisterResponse> registerUser(RegisterEntity user) async {
    final dto = RegisterDto.fromEntity(user);

    try {
      final response = await api.registerUser(dto);

      // optional validation
      if (response.message.isEmpty) {
        throw Exception("Registration failed");
      }

      return response;

    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? 'Register failed';
      throw Exception(msg);

    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
