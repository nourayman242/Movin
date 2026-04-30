import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LogoutService {
  final Dio dio;

  LogoutService(this.dio);

  Future<void> logout() async {
    await dio.post('/api/auth/logout');
  }
}