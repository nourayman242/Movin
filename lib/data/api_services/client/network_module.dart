import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:movin/data/api_services/client/auth_interceptor.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

// Services
import 'package:movin/data/api_services/favorite_api_service.dart';
import 'package:movin/data/api_services/auction_list_services.dart';
import 'package:movin/data/api_services/forget_pass_services.dart';
import 'package:movin/data/api_services/login_services.dart';
import 'package:movin/data/api_services/otp_services.dart';
import 'package:movin/data/api_services/profile_services.dart';
import 'package:movin/data/api_services/property_services.dart';
import 'package:movin/data/api_services/register_services.dart';
import 'package:movin/data/api_services/role_services.dart';
import 'package:movin/data/api_services/reset_password_service.dart';
import 'package:movin/data/api_services/socket_service.dart';

// Repositories (data)
import 'package:movin/data/repositories/property_repository_impl.dart';
import 'package:movin/data/repositories/profile_repository_impl.dart';
import 'package:movin/data/repositories/forget_pass_repository_imp.dart';
import 'package:movin/data/repositories/auction_repository_impl.dart';

// Domain
import 'package:movin/domain/repositories/property_repository.dart';
import 'package:movin/domain/repositories/profile_repository.dart';
import 'package:movin/domain/repositories/forget_pass_repository.dart';
import 'package:movin/domain/repositories/otp_repository.dart';
import 'package:movin/domain/repositories/reset_pass_repository.dart';
import 'package:movin/domain/repositories/auction_repository.dart';

// Cubits
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';
import 'package:movin/presentation/login/cubit/otp_cubit.dart';
import 'package:movin/presentation/login/cubit/reset_pass_cubit.dart';
import 'package:movin/presentation/login/cubit/forget_pass_cubit.dart';
import 'package:movin/presentation/profile/cubit/profile_cubit.dart';
import 'package:movin/presentation/auction/cubit/auction_cubit.dart';
import 'package:movin/presentation/auction/cubit/auction_list_cubit.dart';

import '../logout_services.dart';

@module
abstract class NetworkModule {


  @lazySingleton
  Dio dio() {
    const baseUrl =
        'https://movin-backend-production.up.railway.app';

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );

    // 1️⃣ AUTH INTERCEPTOR (TOKEN)
    dio.interceptors.add(AuthInterceptor(dio));

    // 2️⃣ LOGGING INTERCEPTOR
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );

    // 3️⃣ DEBUG / ERROR HANDLER INTERCEPTOR
    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onRequest: (options, handler)
    //
    //     {
    //
    //
    //       debugPrint("REQUEST → ${options.method} ${options.uri}");
    //       return handler.next(options);
    //     },
    //     onResponse: (response, handler) {
    //       debugPrint("RESPONSE → ${response.statusCode}");
    //       return handler.next(response);
    //     },
    //     onError: (error, handler) {
    //       debugPrint("ERROR → ${error.message}");
    //       return handler.next(error);
    //     },
    //   ),
    //);

    return dio;
  }

  // =======================
  // SERVICES
  // =======================

  @lazySingleton
  RegisterServices registerServices(Dio dio) => RegisterServices(dio);

  @lazySingleton
  LoginServices loginServices(Dio dio) => LoginServices(dio);

  @lazySingleton
  ForgotPasswordService forgotPasswordService(Dio dio) =>
      ForgotPasswordService(dio);

  @lazySingleton
  FavoriteApiService favoriteApiService(Dio dio) =>
      FavoriteApiService(dio);

  @lazySingleton
  RoleServices roleServices(Dio dio) => RoleServices(dio);

  @lazySingleton
  PropertyService propertyService(Dio dio) => PropertyService(dio);

  @lazySingleton
  OtpServices otpServices(Dio dio) => OtpServices(dio);

  @lazySingleton
  ResetPasswordService resetPasswordService(Dio dio) =>
      ResetPasswordService(dio);

  @lazySingleton
  ProfileService profileService(Dio dio) => ProfileService(dio);

  @lazySingleton
  AuctionListService auctionListService(Dio dio) =>
      AuctionListService(dio);

  // =======================
  // SOCKET
  // =======================

  @lazySingleton
  SocketService socketService() {
    final s = SocketService();
    s.connect();
    return s;
  }

  // =======================
  // REPOSITORIES
  // =======================

  @lazySingleton
  PropertyRepository propertyRepository(PropertyService service) =>
      PropertyRepositoryImpl(service);

  @lazySingleton
  ProfileRepository profileRepository(ProfileService service) =>
      ProfileRepositoryImpl(service);

  @lazySingleton
  ForgotPasswordRepository forgotPasswordRepository(
      ForgotPasswordService service) =>
      ForgotPasswordRepositoryImpl(service);

  @lazySingleton
  AuctionRepository auctionRepository(SocketService socketService) =>
      AuctionRepositoryImpl(socketService);

  // =======================
  // CUBITS
  // =======================

  @factory
  PropertyCubit propertyCubit(PropertyRepository repo) =>
      PropertyCubit(repo);

  @factory
  OtpCubit otpCubit(OtpRepository repo) => OtpCubit(repo);

  @factory
  ResetPasswordCubit resetPasswordCubit(
      ResetPasswordRepository repo) =>
      ResetPasswordCubit(repo);

  @factory
  ForgotPasswordCubit forgotPasswordCubit(
      ForgotPasswordRepository repo) =>
      ForgotPasswordCubit(repo);

  @factory
  ProfileCubit profileCubit(ProfileRepository repo) =>
      ProfileCubit(repo);

  @factory
  AuctionCubit auctionCubit(AuctionRepository repo) =>
      AuctionCubit(repo);

  @factory
  AuctionListCubit auctionListCubit(AuctionListService service) =>
      AuctionListCubit(service);

  // @lazySingleton
  // LogoutService logoutService(Dio dio) => LogoutService(dio);
}
