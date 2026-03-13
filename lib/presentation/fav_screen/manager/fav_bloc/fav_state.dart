import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final Set<String> favorites;
  final bool loaded;

  const FavoriteState({
    required this.favorites,
    this.loaded = false,
  });

  bool isFavorite(String id) => favorites.contains(id);

  FavoriteState copyWith({
    Set<String>? favorites,
    bool? loaded,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      loaded: loaded ?? this.loaded,
    );
  }

  @override
  List<Object?> get props => [favorites, loaded];
}
