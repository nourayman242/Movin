import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/repositories/news_repository.dart';
import 'news_state.dart';

@injectable
class NewsCubit extends Cubit<NewsState> {
  final NewsRepository repo;
  NewsCubit(this.repo) : super(NewsInitial());

  Future<void> getNews() async {
    emit(NewsLoading());
    try {
      final result = await repo.getRealEstateNews();
      emit(NewsLoaded(result));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}