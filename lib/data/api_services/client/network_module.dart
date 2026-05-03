import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/auction_list_services.dart';
import 'package:movin/data/api_services/client/auth_interceptor.dart';
import 'package:movin/data/api_services/forget_pass_services.dart';
import 'package:movin/data/api_services/login_services.dart';
import 'package:movin/data/api_services/otp_services.dart';
import 'package:movin/data/api_services/profile_services.dart';
import 'package:movin/data/api_services/property_services.dart';
import 'package:movin/data/api_services/register_services.dart';
import 'package:movin/data/api_services/reset_password_service.dart';
import 'package:movin/data/api_services/socket_service.dart';
import 'package:movin/data/repositories/auction_repository_impl.dart';

import 'package:movin/data/repositories/forget_pass_repository_imp.dart';
import 'package:movin/data/repositories/profile_repository_impl.dart';

import 'package:movin/data/repositories/property_repository_impl.dart';
import 'package:movin/domain/repositories/auction_repository.dart';
import 'package:movin/domain/repositories/forget_pass_repository.dart';
import 'package:movin/domain/repositories/otp_repository.dart';
import 'package:movin/domain/repositories/profile_repository.dart';
import 'package:movin/domain/repositories/property_repository.dart';
import 'package:movin/domain/repositories/reset_pass_repository.dart';
import 'package:movin/presentation/auction/cubit/auction_cubit.dart';
import 'package:movin/presentation/auction/cubit/auction_list_cubit.dart';
import 'package:movin/presentation/login/cubit/forget_pass_cubit.dart';
import 'package:movin/presentation/login/cubit/otp_cubit.dart';
import 'package:movin/presentation/login/cubit/reset_pass_cubit.dart';
import 'package:movin/presentation/profile/cubit/profile_cubit.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';

import '../favorite_api_service.dart';
import '../role_services.dart';
import '../verify_email_service.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio provideDio() {
    const base = 'https://movin-backend-production.up.railway.app';

    final dio = Dio(
      BaseOptions(
        baseUrl: base,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(AuthInterceptor(dio));
    dio.interceptors.add(_RetryInterceptor(dio));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }

  @Named('vercelDio')
  @lazySingleton
  Dio provideVercelDio() {
    const base = 'https://movin-app.vercel.app';

    final dio = Dio(
      BaseOptions(
        baseUrl: base,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(_RetryInterceptor(dio));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }

  @Named('newsDio')
  @lazySingleton
  Dio provideNewsDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  }

  @lazySingleton
  ForgotPasswordService forgotPasswordService(@Named('vercelDio') Dio dio) {
    return ForgotPasswordService(dio);
  }

  @lazySingleton
  OtpServices otpServices(@Named('vercelDio') Dio dio) => OtpServices(dio);

  @lazySingleton
  RegisterServices registerServices(Dio dio) => RegisterServices(dio);

  @lazySingleton
  LoginServices loginServices(Dio dio) => LoginServices(dio);

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

  @factory
  OtpCubit otpCubit(OtpRepository repo) => OtpCubit(repo);

  @lazySingleton
  ResetPasswordService resetPasswordService(@Named('vercelDio') Dio dio) =>
      ResetPasswordService(dio);

  @factory
  ResetPasswordCubit resetPasswordCubit(ResetPasswordRepository repo) =>
      ResetPasswordCubit(repo);

  @lazySingleton
  SocketService socketService() {
    final s = SocketService();
    s.connect();
    return s;
  }

  @lazySingleton
  AuctionRepository auctionRepository(SocketService socketService) =>
      AuctionRepositoryImpl(socketService);

  @factory
  AuctionCubit auctionCubit(AuctionRepository repo) => AuctionCubit(repo);

  @lazySingleton
  ProfileService profileService(Dio dio) => ProfileService(dio);

  @lazySingleton
  ProfileRepository profileRepository(ProfileService service) =>
      ProfileRepositoryImpl(service);

  @factory
  ProfileCubit profileCubit(ProfileRepository repo) => ProfileCubit(repo);

  @lazySingleton
  AuctionListService auctionListService(Dio dio) => AuctionListService(dio);

  @factory
  AuctionListCubit auctionListCubit(AuctionListService service) =>
      AuctionListCubit(service);

  @lazySingleton
  VerifyEmailService verifyEmailService(Dio dio) => VerifyEmailService(dio);

  @lazySingleton
  FavoriteApiService favoriteApiService(Dio dio) => FavoriteApiService(dio);

  @lazySingleton
  RoleServices roleServices(Dio dio) => RoleServices(dio);
}

class _RetryInterceptor extends Interceptor {
  final Dio dio;
  _RetryInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final isTimeout =
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionTimeout;
    final alreadyRetried = err.requestOptions.extra['retried'] == true;

    if (isTimeout && !alreadyRetried) {
      final opts = err.requestOptions..extra['retried'] = true;
      try {
        final response = await dio.fetch(opts);
        return handler.resolve(response);
      } catch (e) {
        // fall through to original error
      }
    }
    handler.next(err);
  }
}
