import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/domain/entities/property_entity.dart';

class AreaScore {
  final String name;
  final LatLng center;
  final int listingCount;
  final double distanceKm;
  final List<PropertyEntity> listings;

  AreaScore({
    required this.name,
    required this.center,
    required this.listingCount,
    this.distanceKm = -1, 
    this.listings = const [],
  });

  double get score {
    if (distanceKm < 0) return -1; 
    if (distanceKm <= 3) return 100;
    if (distanceKm <= 8) return 70;
    if (distanceKm <= 15) return 40;
    return 10;
  }
}