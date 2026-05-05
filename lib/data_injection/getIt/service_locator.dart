import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/presentation/fav_screen/manager/fav_hive.dart';
import '../../presentation/notifications/managers/notification_hive/notification_hive_services.dart';
import 'service_locator.config.dart';
import 'package:movin/data/api_services/client/network_module.dart';


final getIt = GetIt.instance;

//@InjectableInit()
@InjectableInit(
 initializerName: 'init',
 preferRelativeImports: true,
 asExtension: true,
)
Future<void> setUpServiceLocator() async {
 await getIt.init();

  final favHive = getIt<FavoriteHiveService>();
  await favHive.init();

 final notificationHive = getIt<NotificationHiveService>();
 await notificationHive.init();

}
