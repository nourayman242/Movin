import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/presentation/fav_screen/manager/fav_hive.dart';
import 'service_locator.config.dart';


final getIt = GetIt.instance;

@InjectableInit()
Future<void> setUpServiceLocator() async {
 await getIt.init();

  final favHive = getIt<FavoriteHiveService>();
  await favHive.init();

}
