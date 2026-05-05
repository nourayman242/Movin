import 'package:injectable/injectable.dart';

import '../../domain/repositories/property_evaluation_repository.dart';
import '../api_services/property_evaluation_service.dart';
import '../models/prediction_request_model.dart';
import '../models/prediction_response_model.dart';
import '../models/property_meatdata_model.dart';

@LazySingleton(as: PropertyEvaluationRepository)
class PropertyEvaluationRepositoryImpl
    implements PropertyEvaluationRepository {
  final PropertyEvaluationService service;

  PropertyEvaluationRepositoryImpl(this.service);

  @override
  Future<PropertyMetadataModel> getMetadata() {
    return service.getMetadata();
  }

  @override
  Future<PredictionResponseModel> predictPrice(
      PredictionRequestModel request,
      ) {
    return service.predictPrice(request);
  }
}