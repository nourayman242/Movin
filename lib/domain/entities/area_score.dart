// lib/domain/entities/area_score.dart
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AreaScore {
  final String name;
  final LatLng center;
  final double score;
  final int listingCount;
  final double distanceKm; // distance from selected area

  AreaScore({
    required this.name,
    required this.center,
    required this.score,
    required this.listingCount,
    this.distanceKm = 0,
  });
}