import 'package:movin/domain/entities/views_chart_entity.dart';

class ViewsChartModel extends ViewsChartEntity {
  ViewsChartModel({
    required super.labels,
    required super.data,
  });

  factory ViewsChartModel.fromJson(Map<String, dynamic> json) {
    final chart = json['chart'];

    return ViewsChartModel(
      labels: List<String>.from(chart['labels']),
      data: List<int>.from(chart['data']),
    );
  }
}