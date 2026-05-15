import '../entities/area_score.dart';

abstract class HeatmapRepository {
  Future<List<AreaScore>> getAreaScores({
    String? propertyType,
    String? bedrooms,
    String? bathrooms,
    bool? hasPool,
    double? minPrice,
    double? maxPrice,
  });
}
