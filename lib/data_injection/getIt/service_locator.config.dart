// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movin/data/api_services/google_auth_service.dart' as _i137;
import 'package:movin/data/api_services/login_services.dart' as _i633;
import 'package:movin/data/api_services/otp_services.dart' as _i97;
import 'package:movin/data/api_services/register_services.dart' as _i232;
import 'package:movin/data/api_services/reset_password_service.dart' as _i295;
import 'package:movin/data/data_source/local/auth_local_services.dart' as _i282;
import 'package:movin/data/data_source/local/settings_local_services.dart'
    as _i87;
import 'package:movin/data/repositories/auth_repository_impl.dart' as _i373;
import 'package:movin/data/repositories/login_repository_imp.dart' as _i107;
import 'package:movin/data/repositories/otp_repository_imp.dart' as _i736;
import 'package:movin/data/repositories/register_repository_imp.dart' as _i666;
import 'package:movin/data/repositories/reset_passwrod_repository_imp.dart'
    as _i684;
import 'package:movin/domain/repositories/auth_repository.dart' as _i1021;
import 'package:movin/domain/repositories/login_repositories.dart' as _i772;
import 'package:movin/domain/repositories/otp_repository.dart' as _i574;
import 'package:movin/domain/repositories/register_repository.dart' as _i623;
import 'package:movin/domain/repositories/reset_pass_repository.dart' as _i332;
import 'package:movin/presentation/budget_calculator/managers/bc_bloc/loan_calc_bloc.dart'
    as _i872;
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_bloc.dart'
    as _i841;
import 'package:movin/presentation/fav_screen/manager/fav_hive.dart' as _i718;
import 'package:movin/presentation/login/cubit/auth_cubit.dart' as _i288;
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
    gh.factory<_i872.LoanCalcBloc>(() => _i872.LoanCalcBloc());
    gh.lazySingleton<_i137.GoogleAuthService>(() => _i137.GoogleAuthService());
    gh.lazySingleton<_i282.AuthLocalService>(() => _i282.AuthLocalService());
    gh.lazySingleton<_i87.SettingsLocalService>(
        () => _i87.SettingsLocalService());
    gh.lazySingleton<_i718.FavoriteHiveService>(
        () => _i718.FavoriteHiveService());
    gh.lazySingleton<_i332.ResetPasswordRepository>(() =>
        _i684.ResetPasswordRepositoryImpl(gh<_i295.ResetPasswordService>()));
    gh.lazySingleton<_i574.OtpRepository>(
        () => _i736.OtpRepositoryImpl(gh<_i97.OtpServices>()));
    gh.lazySingleton<_i1021.AuthRepository>(
        () => _i373.AuthRepositoryImpl(gh<_i137.GoogleAuthService>()));
    gh.lazySingleton<_i772.LoginRepository>(
        () => _i107.LoginRepositoryImpl(gh<_i633.LoginServices>()));
    gh.factory<_i617.SettingsBloc>(() => _i617.SettingsBloc(
          gh<_i87.SettingsLocalService>(),
          gh<_i282.AuthLocalService>(),
        ));
    gh.factory<_i841.FavoriteBloc>(
        () => _i841.FavoriteBloc(gh<_i718.FavoriteHiveService>()));
    gh.lazySingleton<_i623.RegisterRepository>(
        () => _i666.RegisterRepositoryImpl(gh<_i232.RegisterServices>()));
    gh.factory<_i288.AuthCubit>(
        () => _i288.AuthCubit(gh<_i1021.AuthRepository>()));
    return this;
  }
}
