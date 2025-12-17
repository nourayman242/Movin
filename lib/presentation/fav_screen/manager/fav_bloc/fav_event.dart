import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteLoad extends FavoriteEvent {}
class FavoriteToggle extends FavoriteEvent {
  final int propertyId;
  FavoriteToggle(this.propertyId);
  @override
  List<Object?> get props => [propertyId];
}
class FavoriteRemove extends FavoriteEvent {
  final int propertyId;
  FavoriteRemove(this.propertyId);
  @override
  List<Object?> get props => [propertyId];
}
class FavoriteClear extends FavoriteEvent {}