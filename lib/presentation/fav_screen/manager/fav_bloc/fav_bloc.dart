import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/repositories/fav_repository.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_event.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_state.dart';

@injectable
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository repo;

  FavoriteBloc(this.repo)
      : super(const FavoriteState(favorites: {}, loaded: false)) {
    on<FavoriteLoad>(_onLoad);
    on<FavoriteToggle>(_onToggle);
    on<FavoriteRemove>(_onRemove);
    on<FavoriteClear>(_onClear);
  }

  Future<void> _onLoad(
      FavoriteLoad event, Emitter<FavoriteState> emit) async {
    final ids = await repo.loadFavorites();
    emit(state.copyWith(favorites: ids, loaded: true));
  }

  Future<void> _onToggle(
      FavoriteToggle event, Emitter<FavoriteState> emit) async {
    final updated = state.isFavorite(event.propertyId)
        ? await repo.remove(event.propertyId)
        : await repo.add(event.propertyId);

    emit(state.copyWith(favorites: updated));
  }

  Future<void> _onRemove(
      FavoriteRemove event, Emitter<FavoriteState> emit) async {
    final updated = await repo.remove(event.propertyId);
    emit(state.copyWith(favorites: updated));
  }

  Future<void> _onClear(
      FavoriteClear event, Emitter<FavoriteState> emit) async {
    await repo.clear();
    emit(state.copyWith(favorites: {}));
  }
}
