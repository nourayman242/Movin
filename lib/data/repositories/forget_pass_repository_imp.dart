import 'package:dio/dio.dart';

import '../../domain/repositories/forget_pass_repository.dart';
import '../api_services/forget_pass_services.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordService service;

  ForgotPasswordRepositoryImpl(this.service);

  @override
Future<String> sendOtp({required String email}) async {
  try {
    final response = await service.sendOtp({"email": email});
    return response.message; 
  } on DioException catch (e) {
    final msg = e.response?.data?['message'] ?? e.message;
    throw Exception(msg);
  }
}
}
