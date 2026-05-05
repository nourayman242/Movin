import 'package:movin/data/models/report_model.dart';

abstract class ReportRepository {
  Future<void> createReport({
    required String subject,
    required String message,
    required String targetType,
    required String targetId,
  });

  Future<List<ReportModel>> getMyReports();
}