class PredictionResponseModel {
  final double predictedPrice;

  PredictionResponseModel({
    required this.predictedPrice,
  });

  factory PredictionResponseModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return PredictionResponseModel(
      predictedPrice:
      (json['predicted_price'] as num).toDouble(),
    );
  }
}