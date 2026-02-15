import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/client/auth_interceptor.dart';
import 'package:movin/data/api_services/forget_pass_services.dart';
import 'package:movin/data/api_services/login_services.dart';
import 'package:movin/data/api_services/property_services.dart';
import 'package:movin/data/api_services/register_services.dart';

import 'package:movin/data/repositories/forget_pass_repository_imp.dart';
import 'package:movin/data/repositories/property_repository_impl.dart';
import 'package:movin/domain/repositories/forget_pass_repository.dart';
import 'package:movin/domain/repositories/property_repository.dart';
import 'package:movin/presentation/login/cubit/forget_pass_cubit.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';

@module
abstract class NetworkServices {
  @lazySingleton
  Dio provideDio() {
    const base =
        'https://movin-oipd650to-malakkhaled22s-projects.vercel.app';

    final dio = Dio(
      BaseOptions(
        baseUrl: base,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    dio.interceptors.add(AuthInterceptor());

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );

    return dio;
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
  ForgotPasswordRepository forgotPasswordRepository(
    ForgotPasswordService service,
  ) {
    return ForgotPasswordRepositoryImpl(service);
  }

  @factory
  ForgotPasswordCubit forgotPasswordCubit(ForgotPasswordRepository repo) {
    return ForgotPasswordCubit(repo);
  }

  @lazySingleton
  PropertyService propertyService(Dio dio) => PropertyService(dio);

  @lazySingleton
  PropertyRepository propertyRepository(PropertyService service) =>
      PropertyRepositoryImpl(service);
  @factory
  PropertyCubit propertyCubit(PropertyRepository repo) => PropertyCubit(repo);
}
