import '../entities/property_entity.dart';

abstract class FavoriteRepository {
  Future<List<PropertyEntity>> loadFavorites();
  Future<Set<String>> add(String id);
  Future<Set<String>> remove(String id);
  Future<void> clear();
}