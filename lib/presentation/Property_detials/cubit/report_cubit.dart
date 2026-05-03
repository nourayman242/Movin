import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/repositories/report_repository.dart';
import 'report_state.dart';

@injectable
class ReportCubit extends Cubit<ReportState> {
  final ReportRepository repo;

  ReportCubit(this.repo) : super(ReportInitial());

  Future<void> createReport({
    required String subject,
    required String message,
    required String targetType,
    required String targetId,
  }) async {
    emit(ReportLoading());

    try {
      await repo.createReport(
        subject: subject,
        message: message,
        targetType: targetType,
        targetId: targetId,
      );

      emit(ReportSuccess("Report submitted successfully"));
    } catch (e) {
      emit(ReportError(e.toString()));
    }
  }

  Future<void> getMyReports() async {
    emit(ReportLoading());

    try {
      final reports = await repo.getMyReports();
      emit(ReportLoaded(reports));
    } catch (e) {
      emit(ReportError(e.toString()));
    }
  }
}