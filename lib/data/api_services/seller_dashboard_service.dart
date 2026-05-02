import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/models/seller_dashboard_stats_model.dart';

@lazySingleton
class SellerDashboardService {
  final Dio dio;

  SellerDashboardService(this.dio);

  Future<SellerDashboardStatsModel> getSellerDashboardStats() async {
    final response = await dio.get('/api/seller/dashboard-stats');

    return SellerDashboardStatsModel.fromJson(response.data);
  }
}