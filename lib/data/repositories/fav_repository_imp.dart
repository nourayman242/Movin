import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/favorite_api_service.dart';
import 'package:movin/data/api_services/favorite_response.dart';
import 'package:movin/domain/repositories/fav_repository.dart';
import 'package:movin/presentation/fav_screen/manager/fav_hive.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteApiService api;
  final FavoriteHiveService hive;

  FavoriteRepositoryImpl(this.api, this.hive);

  @override
  Future<Set<String>> loadFavorites() async {
    final raw = await api.getFavorites();
    final response = FavoriteResponse.fromMap(raw);
    final ids = response.favorites.toSet();
    await hive.saveFavorites(ids);
    return ids;
  }

  @override
  Future<Set<String>> add(String id) async {
    final raw = await api.addFavorite(id);
    final response = FavoriteResponse.fromMap(raw);
    final ids = response.favorites.toSet();
    await hive.saveFavorites(ids);
    return ids;
  }

  @override
  Future<Set<String>> remove(String id) async {
    final raw = await api.removeFavorite(id);
    final response = FavoriteResponse.fromMap(raw);
    final ids = response.favorites.toSet();
    await hive.saveFavorites(ids);
    return ids;
  }

  @override
  Future<void> clear() async {
    await api.clearFavorites();
    await hive.clear();
  }
}
