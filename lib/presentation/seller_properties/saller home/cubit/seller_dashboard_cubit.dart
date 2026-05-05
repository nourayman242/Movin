import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/repositories/seller_dashboard_repository.dart';
import 'seller_dashboard_state.dart';

@injectable
class SellerDashboardCubit extends Cubit<SellerDashboardState> {
  final SellerDashboardRepository repository;

  SellerDashboardCubit(this.repository) : super(SellerDashboardInitial());

  Future<void> getSellerDashboardStats() async {
    emit(SellerDashboardLoading());

    try {
      final result = await repository.getSellerDashboardStats();
      emit(SellerDashboardLoaded(result));
    } catch (e) {
      emit(SellerDashboardError(e.toString()));
    }
  }
}