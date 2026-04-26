import '../entities/area_score.dart';

abstract class HeatmapRepository {
  Future<List<AreaScore>> getAreaScores();
}
