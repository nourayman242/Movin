import 'package:movin/data/models/seller_dashboard_stats_model.dart';

abstract class SellerDashboardState {}

class SellerDashboardInitial extends SellerDashboardState {}

class SellerDashboardLoading extends SellerDashboardState {}

class SellerDashboardLoaded extends SellerDashboardState {
  final SellerDashboardStatsModel stats;

  SellerDashboardLoaded(this.stats);
}

class SellerDashboardError extends SellerDashboardState {
  final String message;

  SellerDashboardError(this.message);
}