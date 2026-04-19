import 'package:google_maps_flutter/google_maps_flutter.dart';

class AreaScore {
  final String name;
  final LatLng center;
  final double score;       // 0–100, drives color
  final int listingCount;   // shown on the pin bubble

  AreaScore({
    required this.name,
    required this.center,
    required this.score,
    required this.listingCount,
  });
}