// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/api_services/auction_list_services.dart' as _i655;
import '../../data/api_services/client/network_module.dart' as _i979;
import '../../data/api_services/favorite_api_service.dart' as _i653;
import '../../data/api_services/forget_pass_services.dart' as _i959;
import '../../data/api_services/google_auth_service.dart' as _i21;
import '../../data/api_services/login_services.dart' as _i744;
import '../../data/api_services/logout_services.dart' as _i800;
import '../../data/api_services/otp_services.dart' as _i498;
import '../../data/api_services/profile_services.dart' as _i825;
import '../../data/api_services/property_services.dart' as _i409;
import '../../data/api_services/register_services.dart' as _i702;
import '../../data/api_services/reset_password_service.dart' as _i766;
import '../../data/api_services/role_services.dart' as _i241;
import '../../data/api_services/seller_dashboard_service.dart' as _i726;
import '../../data/api_services/socket_service.dart' as _i380;
import '../../data/api_services/verify_email_service.dart' as _i668;
import '../../data/api_services/views_chart_service.dart' as _i54;
import '../../data/data_source/local/auth_local_services.dart' as _i401;
import '../../data/data_source/local/settings_local_services.dart' as _i998;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/fav_repository_imp.dart' as _i76;
import '../../data/repositories/login_repository_imp.dart' as _i809;
import '../../data/repositories/otp_repository_imp.dart' as _i870;
import '../../data/repositories/register_repository_imp.dart' as _i146;
import '../../data/repositories/reset_passwrod_repository_imp.dart' as _i886;
import '../../data/repositories/role_repository_imp.dart' as _i853;
import '../../data/repositories/seller_dashboard_repository_impl.dart' as _i260;
import '../../data/repositories/verify_email_repository_imp.dart' as _i662;
import '../../data/repositories/views_chart_repository_impl.dart' as _i225;
import '../../domain/repositories/auction_repository.dart' as _i892;
import '../../domain/repositories/auth_repository.dart' as _i1073;
import '../../domain/repositories/fav_repository.dart' as _i66;
import '../../domain/repositories/forget_pass_repository.dart' as _i6;
import '../../domain/repositories/login_repositories.dart' as _i386;
import '../../domain/repositories/otp_repository.dart' as _i1046;
import '../../domain/repositories/profile_repository.dart' as _i47;
import '../../domain/repositories/property_repository.dart' as _i906;
import '../../domain/repositories/register_repository.dart' as _i462;
import '../../domain/repositories/reset_pass_repository.dart' as _i934;
import '../../domain/repositories/role_repository.dart' as _i487;
import '../../domain/repositories/seller_dashboard_repository.dart' as _i133;
import '../../domain/repositories/verify_email_repository.dart' as _i661;
import '../../domain/repositories/views_chart_repository.dart' as _i782;
import '../../presentation/auction/create%20auction/cubit/create_auction_cubit.dart'
    as _i953;
import '../../presentation/auction/cubit/auction_cubit.dart' as _i775;
import '../../presentation/auction/cubit/auction_list_cubit.dart' as _i1061;
import '../../presentation/budget_calculator/managers/bc_bloc/loan_calc_bloc.dart'
    as _i882;
import '../../presentation/fav_screen/manager/fav_bloc/fav_bloc.dart' as _i371;
import '../../presentation/fav_screen/manager/fav_hive.dart' as _i588;
import '../../presentation/home/cubit/view_history_cubit.dart' as _i216;
import '../../presentation/login/cubit/auth_cubit.dart' as _i659;
import '../../presentation/login/cubit/forget_pass_cubit.dart' as _i309;
import '../../presentation/login/cubit/otp_cubit.dart' as _i225;
import '../../presentation/login/cubit/reset_pass_cubit.dart' as _i817;
import '../../presentation/profile/cubit/profile_cubit.dart' as _i107;
import '../../presentation/register/managers/verify_email_bloc.dart' as _i1047;
import '../../presentation/role_selection/manager/role_bloc/role_bloc.dart'
    as _i355;
import '../../presentation/seller_properties/cubit/property_cubit.dart'
    as _i484;
import '../../presentation/seller_properties/saller%20home/cubit/most_viewed_cubit.dart'
    as _i625;
import '../../presentation/seller_properties/saller%20home/cubit/seller_dashboard_cubit.dart'
    as _i755;
import '../../presentation/seller_properties/saller%20home/cubit/views_chart_cubit.dart'
    as _i126;
import '../../presentation/settings/managers/settings_bloc/settings_bloc.dart'
    as _i111;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    gh.factory<_i882.LoanCalcBloc>(() => _i882.LoanCalcBloc());
    gh.lazySingleton<_i361.Dio>(() => networkModule.provideDio());
    gh.lazySingleton<_i380.SocketService>(() => networkModule.socketService());
    gh.lazySingleton<_i21.GoogleAuthService>(() => _i21.GoogleAuthService());
    gh.lazySingleton<_i401.AuthLocalService>(() => _i401.AuthLocalService());
    gh.lazySingleton<_i998.SettingsLocalService>(
        () => _i998.SettingsLocalService());
    gh.lazySingleton<_i588.FavoriteHiveService>(
        () => _i588.FavoriteHiveService());
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.provideVercelDio(),
      instanceName: 'vercelDio',
    );
    gh.lazySingleton<_i702.RegisterServices>(
        () => networkModule.registerServices(gh<_i361.Dio>()));
    gh.lazySingleton<_i744.LoginServices>(
        () => networkModule.loginServices(gh<_i361.Dio>()));
    gh.lazySingleton<_i409.PropertyService>(
        () => networkModule.propertyService(gh<_i361.Dio>()));
    gh.lazySingleton<_i825.ProfileService>(
        () => networkModule.profileService(gh<_i361.Dio>()));
    gh.lazySingleton<_i655.AuctionListService>(
        () => networkModule.auctionListService(gh<_i361.Dio>()));
    gh.lazySingleton<_i668.VerifyEmailService>(
        () => networkModule.verifyEmailService(gh<_i361.Dio>()));
    gh.lazySingleton<_i653.FavoriteApiService>(
        () => networkModule.favoriteApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i241.RoleServices>(
        () => networkModule.roleServices(gh<_i361.Dio>()));
    gh.lazySingleton<_i800.LogoutService>(
        () => _i800.LogoutService(gh<_i361.Dio>()));
    gh.lazySingleton<_i726.SellerDashboardService>(
        () => _i726.SellerDashboardService(gh<_i361.Dio>()));
    gh.lazySingleton<_i54.ViewsChartService>(
        () => _i54.ViewsChartService(gh<_i361.Dio>()));
    gh.lazySingleton<_i782.ViewsChartRepository>(
        () => _i225.ViewsChartRepositoryImpl(gh<_i54.ViewsChartService>()));
    gh.lazySingleton<_i47.ProfileRepository>(
        () => networkModule.profileRepository(gh<_i825.ProfileService>()));
    gh.lazySingleton<_i66.FavoriteRepository>(() => _i76.FavoriteRepositoryImpl(
          gh<_i653.FavoriteApiService>(),
          gh<_i588.FavoriteHiveService>(),
        ));
    gh.lazySingleton<_i487.RoleRepository>(
        () => _i853.RoleRepositoryImpl(gh<_i241.RoleServices>()));
    gh.lazySingleton<_i386.LoginRepository>(
        () => _i809.LoginRepositoryImpl(gh<_i744.LoginServices>()));
    gh.factory<_i371.FavoriteBloc>(
        () => _i371.FavoriteBloc(gh<_i66.FavoriteRepository>()));
    gh.factory<_i126.ViewsChartCubit>(
        () => _i126.ViewsChartCubit(gh<_i782.ViewsChartRepository>()));
    gh.factory<_i111.SettingsBloc>(() => _i111.SettingsBloc(
          gh<_i998.SettingsLocalService>(),
          gh<_i401.AuthLocalService>(),
        ));
    gh.lazySingleton<_i133.SellerDashboardRepository>(() =>
        _i260.SellerDashboardRepositoryImpl(
            gh<_i726.SellerDashboardService>()));
    gh.lazySingleton<_i661.VerifyEmailRepository>(
        () => _i662.VerifyEmailRepositoryImpl(gh<_i668.VerifyEmailService>()));
    gh.factory<_i1047.VerifyEmailBloc>(
        () => _i1047.VerifyEmailBloc(gh<_i661.VerifyEmailRepository>()));
    gh.lazySingleton<_i959.ForgotPasswordService>(() => networkModule
        .forgotPasswordService(gh<_i361.Dio>(instanceName: 'vercelDio')));
    gh.lazySingleton<_i498.OtpServices>(() =>
        networkModule.otpServices(gh<_i361.Dio>(instanceName: 'vercelDio')));
    gh.lazySingleton<_i766.ResetPasswordService>(() => networkModule
        .resetPasswordService(gh<_i361.Dio>(instanceName: 'vercelDio')));
    gh.factory<_i107.ProfileCubit>(
        () => networkModule.profileCubit(gh<_i47.ProfileRepository>()));
    gh.factory<_i755.SellerDashboardCubit>(() =>
        _i755.SellerDashboardCubit(gh<_i133.SellerDashboardRepository>()));
    gh.lazySingleton<_i906.PropertyRepository>(
        () => networkModule.propertyRepository(gh<_i409.PropertyService>()));
    gh.lazySingleton<_i462.RegisterRepository>(
        () => _i146.RegisterRepositoryImpl(gh<_i702.RegisterServices>()));
    gh.lazySingleton<_i892.AuctionRepository>(
        () => networkModule.auctionRepository(gh<_i380.SocketService>()));
    gh.lazySingleton<_i934.ResetPasswordRepository>(() =>
        _i886.ResetPasswordRepositoryImpl(gh<_i766.ResetPasswordService>()));
    gh.factory<_i1061.AuctionListCubit>(
        () => networkModule.auctionListCubit(gh<_i655.AuctionListService>()));
    gh.factory<_i484.PropertyCubit>(
        () => networkModule.propertyCubit(gh<_i906.PropertyRepository>()));
    gh.factory<_i953.CreateAuctionCubit>(
        () => _i953.CreateAuctionCubit(gh<_i906.PropertyRepository>()));
    gh.factory<_i625.MostviewedCubit>(
        () => _i625.MostviewedCubit(gh<_i906.PropertyRepository>()));
    gh.factory<_i355.RoleBloc>(
        () => _i355.RoleBloc(gh<_i487.RoleRepository>()));
    gh.lazySingleton<_i1073.AuthRepository>(() => _i895.AuthRepositoryImpl(
          gh<_i21.GoogleAuthService>(),
          gh<_i800.LogoutService>(),
        ));
    gh.lazySingleton<_i1046.OtpRepository>(
        () => _i870.OtpRepositoryImpl(gh<_i498.OtpServices>()));
    gh.singleton<_i216.ViewHistoryCubit>(
        () => _i216.ViewHistoryCubit(gh<_i906.PropertyRepository>()));
    gh.factory<_i775.AuctionCubit>(
        () => networkModule.auctionCubit(gh<_i892.AuctionRepository>()));
    gh.factory<_i225.OtpCubit>(
        () => networkModule.otpCubit(gh<_i1046.OtpRepository>()));
    gh.lazySingleton<_i6.ForgotPasswordRepository>(() => networkModule
        .forgotPasswordRepository(gh<_i959.ForgotPasswordService>()));
    gh.factory<_i817.ResetPasswordCubit>(() =>
        networkModule.resetPasswordCubit(gh<_i934.ResetPasswordRepository>()));
    gh.factory<_i309.ForgotPasswordCubit>(() =>
        networkModule.forgotPasswordCubit(gh<_i6.ForgotPasswordRepository>()));
    gh.factory<_i659.AuthCubit>(() => _i659.AuthCubit(
          gh<_i1073.AuthRepository>(),
          gh<_i386.LoginRepository>(),
        ));
    return this;
  }
}

class _$NetworkModule extends _i979.NetworkModule {}
