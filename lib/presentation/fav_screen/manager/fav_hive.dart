import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FavoriteHiveService {
  static const String _boxName = 'favorites_box';
  static const String _key = 'favorite_ids';

  late Box box;

  Future<void> init() async {
    box = await Hive.openBox(_boxName);
  }

  Set<String> loadFavorites() {
  final stored = box.get(_key);
  if (stored is List) {
    return Set<String>.from(stored.cast<String>());
  }
  return {};
}

Future<void> saveFavorites(Set<String> ids) async {
  await box.put(_key, ids.toList());
}

  Future<void> clear() async {
    await box.delete(_key);
  }
}
