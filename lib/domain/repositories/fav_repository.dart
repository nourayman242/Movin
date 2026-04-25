abstract class FavoriteRepository {
  Future<Set<String>> loadFavorites();
  Future<Set<String>> add(String id);
  Future<Set<String>> remove(String id);
  Future<void> clear();
}