import 'package:equatable/equatable.dart';
import 'package:movin/domain/entities/property_entity.dart';

class FavoriteState extends Equatable {
  //ids
  final Set<String> favorites;
  //full obj
  final List<PropertyEntity> favoriteProperties;
  final bool loaded;

  const FavoriteState({
    required this.favorites,
    required this.favoriteProperties,
    this.loaded = false,
  });

  bool isFavorite(String id) => favorites.contains(id);

  FavoriteState copyWith({
    Set<String>? favorites,
    List<PropertyEntity>? favoriteProperties,
    bool? loaded,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      favoriteProperties:
      favoriteProperties ?? this.favoriteProperties,
      loaded: loaded ?? this.loaded,
    );
  }

  @override
  List<Object?> get props => [favorites,favoriteProperties, loaded];
}
