import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/google_auth_service.dart';
import 'package:movin/data/repositories/auth_repository_impl.dart';
import 'package:movin/domain/repositories/auth_repository.dart';
import 'package:movin/presentation/fav_screen/manager/fav_hive.dart';
import 'package:movin/presentation/login/cubit/auth_cubit.dart';
import 'service_locator.config.dart';


final getIt = GetIt.instance;

@InjectableInit()
// Future<void> setUpServiceLocator() async {
//   getIt.init();

//   // initi hive service
//   final favHive = getIt<FavoriteHiveService>();
//   await favHive.init();

//  getIt.registerFactory<AuthCubit>(
//   () => AuthCubit(getIt<AuthRepository>()),
// );
// getIt.registerLazySingleton<AuthRepository>(
//   () => AuthRepositoryImpl(),
// );

// }
@InjectableInit()
Future<void> setUpServiceLocator() async {
  getIt.init();

  final favHive = getIt<FavoriteHiveService>();
  await favHive.init();

  // Register Google service
  getIt.registerLazySingleton<GoogleAuthService>(
    () => GoogleAuthService(),
  );

  // Register repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<GoogleAuthService>(),
    ),
  );

  // Register cubit
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<AuthRepository>()),
  );
}
