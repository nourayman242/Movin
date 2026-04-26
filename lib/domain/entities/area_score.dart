import 'package:google_maps_flutter/google_maps_flutter.dart';

class AreaScore {
  final String name;
  final LatLng center;
  final int listingCount;
  final double distanceKm;

  AreaScore({
    required this.name,
    required this.center,
    required this.listingCount,
    this.distanceKm = 0,
  });

  /// Computed from distance — never stored or sent by backend
  double get score {
    if (distanceKm <= 3) return 100;
    if (distanceKm <= 8) return 70;
    if (distanceKm <= 15) return 40;
    return 10;
  }
}