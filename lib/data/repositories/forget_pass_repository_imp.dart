import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/forget_pass_services.dart';
import 'package:movin/data/models/forget_pass_dto.dart';
import 'package:movin/domain/entities/forget_pass_entity.dart';
import 'package:movin/domain/repositories/forget_pass_repository.dart';

@LazySingleton(as: ForgetPassRepository)
class ForgetPassRepositoryImpl implements ForgetPassRepository {
  final ForgetPassServices api;

  ForgetPassRepositoryImpl(this.api);

  Future<void> sendForgetPassword(ForgetPasswordEntity entity) async {
    final dto = ForgetPassDto.fromEntity(entity);
    print('ForgetPass DTO: ${dto.toJson()}');

    try {
      await api.sendForgetPassword(dto); 
      return;
    } on DioError catch (e) {
      final msg = e.response?.data?['message'] ?? e.message;
      throw Exception(msg);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  
  @override
  Future<void> forgetpassword(ForgetPasswordEntity user) {
    // TODO: implement forgetpassword
    throw UnimplementedError();
  }
  
  @override
  Future<void> sendOtp(String email) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }
}
