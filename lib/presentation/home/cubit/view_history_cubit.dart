import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/domain/repositories/property_repository.dart';

part 'view_history_state.dart';

@singleton  
class ViewHistoryCubit extends Cubit<ViewHistoryState> {
  final PropertyRepository repository;
  bool _isCleared = false;

  ViewHistoryCubit(this.repository) : super(ViewHistoryInitial());

  Future<void> loadViewHistory({int page = 1, int limit = 10}) async {
    
    if (_isCleared) {
      emit(ViewHistoryLoaded([]));
      return;
    }

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

  void clearHistory() {
    _isCleared = true;
    emit(ViewHistoryLoaded([]));
  }

 
  Future<void> refresh() async {
    _isCleared = false;
    await loadViewHistory();
  }
}