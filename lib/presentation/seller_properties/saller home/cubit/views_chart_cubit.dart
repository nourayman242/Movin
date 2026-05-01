import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/repositories/views_chart_repository.dart';
import 'views_chart_state.dart';

@injectable
class ViewsChartCubit extends Cubit<ViewsChartState> {
  final ViewsChartRepository repository;

  ViewsChartCubit(this.repository) : super(ViewsChartInitial());

  Future<void> getSellerViewsChart() async {
    emit(ViewsChartLoading());

    try {
      final result = await repository.getSellerViewsChart();
      emit(ViewsChartLoaded(result));
    } catch (e) {
      emit(ViewsChartError(e.toString()));
    }
  }
}