import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/report_service.dart';
import 'package:movin/data/models/report_model.dart';
import 'package:movin/domain/repositories/report_repository.dart';

@LazySingleton(as: ReportRepository)
class ReportRepositoryImpl implements ReportRepository {
  final ReportService service;
  ReportRepositoryImpl(this.service);

  @override
  Future<void> createReport({
    required String subject,
    required String message,
    required String targetType,
    required String targetId,
  }) {
    return service.createReport(
      subject: subject,
      message: message,
      targetType: targetType,
      targetId: targetId,
    );
  }

  @override
  Future<List<ReportModel>> getMyReports() async {
    final data = await service.getMyReports();
    return data.map<ReportModel>((e) => ReportModel.fromJson(e)).toList();
  }
}