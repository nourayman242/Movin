import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/seller_dashboard_service.dart';
import 'package:movin/data/models/seller_dashboard_stats_model.dart';
import 'package:movin/domain/repositories/seller_dashboard_repository.dart';

@LazySingleton(as: SellerDashboardRepository)
class SellerDashboardRepositoryImpl implements SellerDashboardRepository {
  final SellerDashboardService service;

  SellerDashboardRepositoryImpl(this.service);

  @override
  Future<SellerDashboardStatsModel> getSellerDashboardStats() {
    return service.getSellerDashboardStats();
  }
}