import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/views_chart_model.dart';

@lazySingleton
class ViewsChartService {
  final Dio dio;

  ViewsChartService(this.dio);

  Future<ViewsChartModel> getSellerViewsChart() async {
    final response = await dio.get('/api/seller/views-chart');

    return ViewsChartModel.fromJson(response.data);
  }
}