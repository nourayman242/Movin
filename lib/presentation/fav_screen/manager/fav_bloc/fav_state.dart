import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  final Set<int> favorites;
  final bool loaded;

  const FavoriteState({
    required this.favorites,
    this.loaded = false,
  });

  bool isFavorite(int id) => favorites.contains(id);

  FavoriteState copyWith({
    Set<int>? favorites,
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
