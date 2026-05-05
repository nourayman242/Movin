import '../entities/views_chart_entity.dart';

abstract class ViewsChartRepository {
  Future<ViewsChartEntity> getSellerViewsChart();
}