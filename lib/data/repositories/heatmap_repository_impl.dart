import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/area_score.dart';
import '../../domain/repositories/heatmap_repository.dart';
import '../models/area_score_model.dart';

class HeatmapRepositoryImpl implements HeatmapRepository {
  @override
  Future<List<AreaScore>> getAreaScores() async {
    // In production, replace this with a real API call.
    // Score = proximity to searched area (New Cairo).
    // listingCount = how many listings exist in that area.
    return [
      // ── Green (score ≥ 70): close to New Cairo ──
      AreaScoreModel(
        name: 'New Cairo',
        center: const LatLng(30.0285, 31.4913),
        score: 95,
        listingCount: 148,
      ),
      AreaScoreModel(
        name: 'Rehab City',
        center: const LatLng(30.0571, 31.4935),
        score: 82,
        listingCount: 92,
      ),
      AreaScoreModel(
        name: 'Madinaty',
        center: const LatLng(30.1025, 31.6038),
        score: 75,
        listingCount: 61,
      ),

      // ── Orange (score 40–69): moderate distance ──
      AreaScoreModel(
        name: 'Nasr City',
        center: const LatLng(30.0519, 31.3656),
        score: 58,
        listingCount: 44,
      ),
      AreaScoreModel(
        name: 'Shorouk City',
        center: const LatLng(30.1468, 31.6091),
        score: 48,
        listingCount: 37,
      ),

      // ── Red (score < 40): far from search ──
      AreaScoreModel(
        name: 'Heliopolis',
        center: const LatLng(30.0870, 31.3220),
        score: 30,
        listingCount: 29,
      ),
      AreaScoreModel(
        name: 'Downtown Cairo',
        center: const LatLng(30.0444, 31.2357),
        score: 18,
        listingCount: 17,
      ),
      AreaScoreModel(
        name: 'Giza',
        center: const LatLng(30.0131, 31.2089),
        score: 12,
        listingCount: 9,
      ),
    ];
  }
}