import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/domain/repositories/property_repository.dart';

part 'view_history_state.dart';

@singleton
class ViewHistoryCubit extends Cubit<ViewHistoryState> {
  final PropertyRepository repository;

  ViewHistoryCubit(this.repository) : super(ViewHistoryInitial());

  Future<void> loadViewHistory({int page = 1, int limit = 10}) async {
    emit(ViewHistoryLoading());
    try {
      final properties = await repository.getViewHistory(
        page: page,
        limit: limit,
      );
      emit(ViewHistoryLoaded(properties));
    } catch (e) {
      emit(ViewHistoryError(e.toString()));
    }
  }

  Future<void> clearHistory() async {
    try {
      await repository.clearViewHistory();
      emit(ViewHistoryLoaded([]));
    } catch (e) {
      emit(ViewHistoryError('Failed to clear history: $e'));
    }
  }

  Future<void> refresh() async {
    await loadViewHistory();
  }
}