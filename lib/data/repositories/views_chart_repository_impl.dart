import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/views_chart_service.dart';
import 'package:movin/domain/entities/views_chart_entity.dart';
import 'package:movin/domain/repositories/views_chart_repository.dart';

@LazySingleton(as: ViewsChartRepository)
class ViewsChartRepositoryImpl implements ViewsChartRepository {
  final ViewsChartService service;

  ViewsChartRepositoryImpl(this.service);

  @override
  Future<ViewsChartEntity> getSellerViewsChart() async {
    return await service.getSellerViewsChart();
  }
}