import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/area_score.dart';
import '../../domain/repositories/heatmap_repository.dart';
import '../models/area_score_model.dart';

class HeatmapRepositoryImpl implements HeatmapRepository {
  
  static const _baseUrl = 'https://movin-backend.fly.dev';

  @override
  Future<List<AreaScore>> getAreaScores() async {
    // ── Uncomment when backend is ready ──────────────────────────────────
    // final res = await http.get(Uri.parse('$_baseUrl/heatmap/areas'));
    // if (res.statusCode != 200) throw Exception('Failed to load heatmap areas');
    // final List data = jsonDecode(res.body) as List;
    // return data.map((j) => AreaScoreModel.fromJson(j)).toList();
    // ─────────────────────────────────────────────────────────────────────

    // Mock data — remove once API is connected
    await Future.delayed(const Duration(milliseconds: 400)); // simulate latency
    return [
      AreaScoreModel(name: 'New Cairo',      center: const LatLng(30.0285, 31.4913), listingCount: 148),
      AreaScoreModel(name: 'Rehab City',     center: const LatLng(30.0571, 31.4935), listingCount: 92),
      AreaScoreModel(name: 'Madinaty',       center: const LatLng(30.1025, 31.6038), listingCount: 61),
      AreaScoreModel(name: 'Nasr City',      center: const LatLng(30.0519, 31.3656), listingCount: 44),
      AreaScoreModel(name: 'Shorouk City',   center: const LatLng(30.1468, 31.6091), listingCount: 37),
      AreaScoreModel(name: 'Heliopolis',     center: const LatLng(30.0870, 31.3220), listingCount: 29),
      AreaScoreModel(name: 'Downtown Cairo', center: const LatLng(30.0444, 31.2357), listingCount: 17),
      AreaScoreModel(name: 'Giza',           center: const LatLng(30.0131, 31.2089), listingCount: 9),
    ];
  }
}