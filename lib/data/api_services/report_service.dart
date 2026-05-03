import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ReportService {
  final Dio dio;
  ReportService(this.dio);

  Future<void> createReport({
    required String subject,
    required String message,
    required String targetType,
    required String targetId,
  }) async {
    await dio.post(
      '/api/reports',
      data: {
        "subject": subject,
        "message": message,
        "targetType": targetType,
        "targetId": targetId,
      },
    );
  }

  Future<List<dynamic>> getMyReports() async {
    final response = await dio.get('/api/reports/my');
    return response.data['reports'];
  }
}