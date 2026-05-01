part of 'view_history_cubit.dart';

abstract class ViewHistoryState {}

class ViewHistoryInitial extends ViewHistoryState {}

class ViewHistoryLoading extends ViewHistoryState {}

class ViewHistoryLoaded extends ViewHistoryState {
  final List<PropertyEntity> properties;
  ViewHistoryLoaded(this.properties);
}

class ViewHistoryError extends ViewHistoryState {
  final String message;
  ViewHistoryError(this.message);
}