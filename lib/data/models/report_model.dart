class ReportModel {
  final String id;
  final String subject;
  final String message;
  final String targetType;
  final String status;
  final DateTime createdAt;

  ReportModel({
    required this.id,
    required this.subject,
    required this.message,
    required this.targetType,
    required this.status,
    required this.createdAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['_id'] ?? '',
      subject: json['subject'] ?? '',
      message: json['message'] ?? '',
      targetType: json['targetType'] ?? '',
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}