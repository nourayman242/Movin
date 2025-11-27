import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/register_services.dart';

@module
abstract class NetworkServices {
  @lazySingleton
  Dio get dio {
    final base = 'https://movin-app-production.up.railway.app';
    
    // kIsWeb
    // ? 'http://localhost:5000' //chrome
    // : 'http://10.0.2.2:5000'; //emulator
    final options = BaseOptions(
      baseUrl: base,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    );
    return Dio(options);
  }

  @lazySingleton
  RegisterServices registerServices(Dio dio) {
    return RegisterServices(dio);
  }
}
