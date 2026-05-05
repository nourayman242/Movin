import 'package:movin/data/models/seller_dashboard_stats_model.dart';

abstract class SellerDashboardRepository {
  Future<SellerDashboardStatsModel> getSellerDashboardStats();
}