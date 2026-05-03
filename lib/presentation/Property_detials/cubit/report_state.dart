import 'package:movin/data/models/report_model.dart';

abstract class ReportState {}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportSuccess extends ReportState {
  final String message;
  ReportSuccess(this.message);
}

class ReportLoaded extends ReportState {
  final List<ReportModel> reports;
  ReportLoaded(this.reports);
}

class ReportError extends ReportState {
  final String message;
  ReportError(this.message);
}