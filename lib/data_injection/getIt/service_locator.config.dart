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
import 'package:movin/data/api_services/auction_list_services.dart' as _i467;
import 'package:movin/data/api_services/client/network_module.dart' as _i324;
import 'package:movin/data/api_services/forget_pass_services.dart' as _i753;
import 'package:movin/data/api_services/google_auth_service.dart' as _i137;
import 'package:movin/data/api_services/login_services.dart' as _i633;
import 'package:movin/data/api_services/otp_services.dart' as _i97;
import 'package:movin/data/api_services/profile_services.dart' as _i163;
import 'package:movin/data/api_services/property_services.dart' as _i634;
import 'package:movin/data/api_services/register_services.dart' as _i232;
import 'package:movin/data/api_services/reset_password_service.dart' as _i295;
import 'package:movin/data/api_services/socket_service.dart' as _i731;
import 'package:movin/data/data_source/local/auth_local_services.dart' as _i282;
import 'package:movin/data/data_source/local/settings_local_services.dart'
    as _i87;
import 'package:movin/data/repositories/auth_repository_impl.dart' as _i373;
import 'package:movin/data/repositories/login_repository_imp.dart' as _i107;
import 'package:movin/data/repositories/otp_repository_imp.dart' as _i736;
import 'package:movin/data/repositories/register_repository_imp.dart' as _i666;
import 'package:movin/data/repositories/reset_passwrod_repository_imp.dart'
    as _i684;
import 'package:movin/domain/repositories/auction_repository.dart' as _i701;
import 'package:movin/domain/repositories/auth_repository.dart' as _i1021;
import 'package:movin/domain/repositories/forget_pass_repository.dart' as _i686;
import 'package:movin/domain/repositories/login_repositories.dart' as _i772;
import 'package:movin/domain/repositories/otp_repository.dart' as _i574;
import 'package:movin/domain/repositories/profile_repository.dart' as _i935;
import 'package:movin/domain/repositories/property_repository.dart' as _i770;
import 'package:movin/domain/repositories/register_repository.dart' as _i623;
import 'package:movin/domain/repositories/reset_pass_repository.dart' as _i332;
import 'package:movin/presentation/auction/cubit/auction_cubit.dart' as _i473;
import 'package:movin/presentation/auction/cubit/auction_list_cubit.dart'
    as _i790;
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_bloc.dart'
    as _i872;
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_bloc.dart'
    as _i841;
import 'package:movin/presentation/fav_screen/manager/fav_hive.dart' as _i718;
import 'package:movin/presentation/login/cubit/auth_cubit.dart' as _i288;
import 'package:movin/presentation/login/cubit/forget_pass_cubit.dart' as _i493;
import 'package:movin/presentation/login/cubit/otp_cubit.dart' as _i898;
import 'package:movin/presentation/login/cubit/reset_pass_cubit.dart' as _i896;
import 'package:movin/presentation/profile/cubit/profile_cubit.dart' as _i981;
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart'
    as _i267;
import 'package:movin/presentation/settings/managers/settings_bloc/settings_bloc.dart'
    as _i617;

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
    final networkServices = _$NetworkServices();
    gh.factory<_i872.LoanCalcBloc>(() => _i872.LoanCalcBloc());
    gh.lazySingleton<_i361.Dio>(() => networkServices.provideDio());
    gh.lazySingleton<_i731.SocketService>(
        () => networkServices.socketService());
    gh.lazySingleton<_i137.GoogleAuthService>(() => _i137.GoogleAuthService());
    gh.lazySingleton<_i282.AuthLocalService>(() => _i282.AuthLocalService());
    gh.lazySingleton<_i87.SettingsLocalService>(
        () => _i87.SettingsLocalService());
    gh.lazySingleton<_i718.FavoriteHiveService>(
        () => _i718.FavoriteHiveService());
    gh.lazySingleton<_i361.Dio>(
      () => networkServices.provideAuthDio(),
      instanceName: 'authDio',
    );
    gh.lazySingleton<_i232.RegisterServices>(
        () => networkServices.registerServices(gh<_i361.Dio>()));
    gh.lazySingleton<_i633.LoginServices>(
        () => networkServices.loginServices(gh<_i361.Dio>()));
    gh.lazySingleton<_i634.PropertyService>(
        () => networkServices.propertyService(gh<_i361.Dio>()));
    gh.lazySingleton<_i163.ProfileService>(
        () => networkServices.profileService(gh<_i361.Dio>()));
    gh.lazySingleton<_i467.AuctionListService>(
        () => networkServices.auctionListService(gh<_i361.Dio>()));
    gh.lazySingleton<_i935.ProfileRepository>(
        () => networkServices.profileRepository(gh<_i163.ProfileService>()));
    gh.lazySingleton<_i1021.AuthRepository>(
        () => _i373.AuthRepositoryImpl(gh<_i137.GoogleAuthService>()));
    gh.lazySingleton<_i772.LoginRepository>(
        () => _i107.LoginRepositoryImpl(gh<_i633.LoginServices>()));
    gh.factory<_i617.SettingsBloc>(() => _i617.SettingsBloc(
          gh<_i87.SettingsLocalService>(),
          gh<_i282.AuthLocalService>(),
        ));
    gh.factory<_i981.ProfileCubit>(
        () => networkServices.profileCubit(gh<_i935.ProfileRepository>()));
    gh.lazySingleton<_i770.PropertyRepository>(
        () => networkServices.propertyRepository(gh<_i634.PropertyService>()));
    gh.lazySingleton<_i753.ForgotPasswordService>(() => networkServices
        .forgotPasswordService(gh<_i361.Dio>(instanceName: 'authDio')));
    gh.lazySingleton<_i97.OtpServices>(() =>
        networkServices.otpServices(gh<_i361.Dio>(instanceName: 'authDio')));
    gh.lazySingleton<_i295.ResetPasswordService>(() => networkServices
        .resetPasswordService(gh<_i361.Dio>(instanceName: 'authDio')));
    gh.factory<_i841.FavoriteBloc>(
        () => _i841.FavoriteBloc(gh<_i718.FavoriteHiveService>()));
    gh.lazySingleton<_i623.RegisterRepository>(
        () => _i666.RegisterRepositoryImpl(gh<_i232.RegisterServices>()));
    gh.lazySingleton<_i701.AuctionRepository>(
        () => networkServices.auctionRepository(gh<_i731.SocketService>()));
    gh.lazySingleton<_i332.ResetPasswordRepository>(() =>
        _i684.ResetPasswordRepositoryImpl(gh<_i295.ResetPasswordService>()));
    gh.factory<_i790.AuctionListCubit>(
        () => networkServices.auctionListCubit(gh<_i467.AuctionListService>()));
    gh.factory<_i267.PropertyCubit>(
        () => networkServices.propertyCubit(gh<_i770.PropertyRepository>()));
    gh.lazySingleton<_i574.OtpRepository>(
        () => _i736.OtpRepositoryImpl(gh<_i97.OtpServices>()));
    gh.factory<_i288.AuthCubit>(
        () => _i288.AuthCubit(gh<_i1021.AuthRepository>()));
    gh.factory<_i473.AuctionCubit>(
        () => networkServices.auctionCubit(gh<_i701.AuctionRepository>()));
    gh.factory<_i898.OtpCubit>(
        () => networkServices.otpCubit(gh<_i574.OtpRepository>()));
    gh.lazySingleton<_i686.ForgotPasswordRepository>(() => networkServices
        .forgotPasswordRepository(gh<_i753.ForgotPasswordService>()));
    gh.factory<_i896.ResetPasswordCubit>(() => networkServices
        .resetPasswordCubit(gh<_i332.ResetPasswordRepository>()));
    gh.factory<_i493.ForgotPasswordCubit>(() => networkServices
        .forgotPasswordCubit(gh<_i686.ForgotPasswordRepository>()));
    return this;
  }
}

class _$NetworkServices extends _i324.NetworkServices {}
