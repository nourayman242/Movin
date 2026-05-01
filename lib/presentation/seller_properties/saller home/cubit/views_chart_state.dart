import 'package:movin/domain/entities/views_chart_entity.dart';

abstract class ViewsChartState {}

class ViewsChartInitial extends ViewsChartState {}

class ViewsChartLoading extends ViewsChartState {}

class ViewsChartLoaded extends ViewsChartState {
  final ViewsChartEntity chart;

  ViewsChartLoaded(this.chart);
}

class ViewsChartError extends ViewsChartState {
  final String message;

  ViewsChartError(this.message);
}