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
import 'package:movin/data/api_services/client/network_module.dart' as _i324;
import 'package:movin/data/api_services/forget_pass_services.dart' as _i753;
import 'package:movin/data/api_services/otp_services.dart' as _i97;
import 'package:movin/data/api_services/register_services.dart' as _i232;
import 'package:movin/data/repositories/forget_pass_repository_imp.dart'
    as _i777;
import 'package:movin/data/repositories/otp_repository_imp.dart' as _i736;
import 'package:movin/data/repositories/register_repository_imp.dart' as _i666;
import 'package:movin/domain/repositories/forget_pass_repository.dart' as _i686;
import 'package:movin/domain/repositories/otp_repository.dart' as _i574;
import 'package:movin/domain/repositories/register_repository.dart' as _i623;

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
    gh.lazySingleton<_i361.Dio>(() => networkServices.dio);
    gh.lazySingleton<_i686.ForgetPassRepository>(
        () => _i777.ForgetPassRepositoryImpl(gh<_i753.ForgetPassServices>()));
    gh.lazySingleton<_i232.RegisterServices>(
        () => networkServices.registerServices(gh<_i361.Dio>()));
    gh.lazySingleton<_i574.OtpRepository>(
        () => _i736.OtpRepositoryImpl(gh<_i97.OtpServices>()));
    gh.lazySingleton<_i623.RegisterRepository>(
        () => _i666.RegisterRepositoryImpl(gh<_i232.RegisterServices>()));
    return this;
  }
}

class _$NetworkServices extends _i324.NetworkServices {}
