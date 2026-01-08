import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/forget_pass_services.dart';
import 'package:movin/data/api_services/login_services.dart';
import 'package:movin/data/api_services/register_services.dart';
import 'package:movin/data/repositories/forget_pass_repository_imp.dart';
import 'package:movin/domain/repositories/forget_pass_repository.dart';
import 'package:movin/presentation/login/cubit/forget_pass_cubit.dart';

@module
abstract class NetworkServices {
  @lazySingleton
  Dio get dio {
    final base = 'https://movin-oipd650to-malakkhaled22s-projects.vercel.app';
    
    // //'http://192.168.1.16:5000';
    // kIsWeb
    // ? 'http://localhost:5000' //chrome
    // : 'http://10.0.2.2:5000'; //emulator
    final options = BaseOptions(
      baseUrl: base,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    );
    return Dio(options);
  }

  @lazySingleton
  RegisterServices registerServices(Dio dio) {
    return RegisterServices(dio);
  }

  @lazySingleton
  LoginServices loginServices(Dio dio) => LoginServices(dio);

    
  @lazySingleton
  ForgotPasswordService forgotPasswordService(Dio dio) {
    return ForgotPasswordService(dio);
  }

  
  @lazySingleton
  ForgotPasswordRepository forgotPasswordRepository(ForgotPasswordService service) {
    return ForgotPasswordRepositoryImpl(service);
  }

  
  @factory
  ForgotPasswordCubit forgotPasswordCubit(ForgotPasswordRepository repo) {
    return ForgotPasswordCubit(repo);
  }
}
