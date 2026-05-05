import '../../../../data/models/property_meatdata_model.dart';

class PropertyEvaluationState {
  final bool loadingMetadata;

  final bool loadingPrediction;

  final String? error;

  final PropertyMetadataModel? metadata;

  final String? selectedType;

  final String? selectedMainArea;

  final String? selectedSubArea;

  final String? selectedPayment;

  final List<String> subAreas;

  final double? predictedPrice;

  const PropertyEvaluationState({
    this.loadingMetadata = false,
    this.loadingPrediction = false,
    this.error,
    this.metadata,
    this.selectedType,
    this.selectedMainArea,
    this.selectedSubArea,
    this.selectedPayment,
    this.subAreas = const [],
    this.predictedPrice,
  });

  PropertyEvaluationState copyWith({
    bool? loadingMetadata,
    bool? loadingPrediction,
    String? error,
    PropertyMetadataModel? metadata,
    String? selectedType,
    String? selectedMainArea,
    String? selectedSubArea,
    String? selectedPayment,
    List<String>? subAreas,
    double? predictedPrice,
  }) {
    return PropertyEvaluationState(
      loadingMetadata:
      loadingMetadata ??
          this.loadingMetadata,

      loadingPrediction:
      loadingPrediction ??
          this.loadingPrediction,

      error: error,

      metadata: metadata ?? this.metadata,

      selectedType:
      selectedType ?? this.selectedType,

      selectedMainArea:
      selectedMainArea ??
          this.selectedMainArea,

      selectedSubArea:
      selectedSubArea ??
          this.selectedSubArea,

      selectedPayment:
      selectedPayment ??
          this.selectedPayment,

      subAreas:
      subAreas ?? this.subAreas,

      predictedPrice:
      predictedPrice ??
          this.predictedPrice,
    );
  }
}