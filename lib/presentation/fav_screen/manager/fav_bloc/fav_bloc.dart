import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_event.dart';
import 'package:movin/presentation/fav_screen/manager/fav_bloc/fav_state.dart';
import 'package:movin/presentation/fav_screen/manager/fav_hive.dart';

@injectable
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteHiveService hive;

  FavoriteBloc(this.hive)
      : super(FavoriteState(favorites: {}, loaded: false)) {

    on<FavoriteLoad>(_onLoad);
    on<FavoriteToggle>(_onToggle);
    on<FavoriteRemove>(_onRemove);
    on<FavoriteClear>(_onClear);
  }

  Future<void> _onLoad(
      FavoriteLoad event, Emitter<FavoriteState> emit) async {
    final ids = hive.loadFavorites();
    emit(state.copyWith(favorites: ids, loaded: true));
  }

  Future<void> _onToggle(
      FavoriteToggle event, Emitter<FavoriteState> emit) async {
    final updated = Set<int>.from(state.favorites);

    if (updated.contains(event.propertyId)) {
      updated.remove(event.propertyId);
    } else {
      updated.add(event.propertyId);
    }

    await hive.saveFavorites(updated);
    emit(state.copyWith(favorites: updated));
  }

  Future<void> _onRemove(
      FavoriteRemove event, Emitter<FavoriteState> emit) async {
    final updated = Set<int>.from(state.favorites)
      ..remove(event.propertyId);

    await hive.saveFavorites(updated);
    emit(state.copyWith(favorites: updated));
  }

  Future<void> _onClear(
      FavoriteClear event, Emitter<FavoriteState> emit) async {
    await hive.clear();
    emit(state.copyWith(favorites: {}));
  }
}
