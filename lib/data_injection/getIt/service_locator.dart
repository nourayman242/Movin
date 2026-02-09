import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/property_services.dart';
import 'package:movin/data/api_services/upload_service.dart';
import 'package:movin/presentation/fav_screen/manager/fav_hive.dart';
import 'package:movin/presentation/seller_properties/cubit/property_cubit.dart';
import 'service_locator.config.dart';


final getIt= GetIt.instance;

@InjectableInit()
Future<void> setUpServiceLocator() async {
  getIt.init();

  // initi hive service
  final favHive = getIt<FavoriteHiveService>();
  await favHive.init();
}
void initDependencies() {
  // services
  getIt.registerLazySingleton<UploadService>(
    () => UploadService(getIt<Dio>()),
  );

  getIt.registerLazySingleton<PropertyService>(
    () => PropertyService(getIt<Dio>()),
  );

  // cubit (IMPORTANT: Factory, not singleton)
  getIt.registerFactory<PropertyCubit>(
    () => PropertyCubit(
      getIt<UploadService>(),
      getIt<PropertyService>(),
    ),
  );
}

