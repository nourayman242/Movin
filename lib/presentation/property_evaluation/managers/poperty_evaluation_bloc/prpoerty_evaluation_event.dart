abstract class PropertyEvaluationEvent {}

class GetPropertyMetadataEvent
    extends PropertyEvaluationEvent {}

class UpdateMainAreaEvent
    extends PropertyEvaluationEvent {
  final String mainArea;

  UpdateMainAreaEvent(this.mainArea);
}

class UpdatePropertyTypeEvent
    extends PropertyEvaluationEvent {
  final String type;

  UpdatePropertyTypeEvent(this.type);
}

class UpdateSubAreaEvent
    extends PropertyEvaluationEvent {
  final String subArea;

  UpdateSubAreaEvent(this.subArea);
}

class UpdatePaymentEvent
    extends PropertyEvaluationEvent {
  final String payment;

  UpdatePaymentEvent(this.payment);
}

class PredictPropertyPriceEvent
    extends PropertyEvaluationEvent {
  final String size;
  final String bedrooms;
  final String bathrooms;

  PredictPropertyPriceEvent({
    required this.size,
    required this.bedrooms,
    required this.bathrooms,
  });
}