import '../../data/models/prediction_request_model.dart';
import '../../data/models/prediction_response_model.dart';
import '../../data/models/property_meatdata_model.dart';

abstract class PropertyEvaluationRepository {
  Future<PropertyMetadataModel> getMetadata();

  Future<PredictionResponseModel> predictPrice(
      PredictionRequestModel request,
      );
}