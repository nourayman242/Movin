import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/prediction_request_model.dart';
import '../models/prediction_response_model.dart';
import '../models/property_meatdata_model.dart';

@lazySingleton
class PropertyEvaluationService {
  final Dio dio;

  PropertyEvaluationService(this.dio);

  Future<PropertyMetadataModel> getMetadata() async {
    final response = await dio.post(
      '/api/map/properties/metadata',
    );

    return PropertyMetadataModel.fromJson(response.data);
  }

  Future<PredictionResponseModel> predictPrice(
      PredictionRequestModel request,
      ) async {
    final response = await dio.post(
      '/api/ai/predict',
      data: request.toJson(),
    );

    return PredictionResponseModel.fromJson(response.data);
  }
}