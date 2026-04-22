import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/domain/entities/area_score.dart';

class AreaScoreModel extends AreaScore {
  AreaScoreModel({
    required String name,
    required LatLng center,
    required int listingCount,
    double distanceKm = 0,
  }) : super(
          name: name,
          center: center,
          listingCount: listingCount,
          distanceKm: distanceKm,
        );

  factory AreaScoreModel.fromJson(Map<String, dynamic> json) {
    return AreaScoreModel(
      name: json['name'] as String,
      center: LatLng(
        (json['lat'] as num).toDouble(),
        (json['lng'] as num).toDouble(),
      ),
      listingCount: json['listing_count'] as int,
      // distanceKm left at 0 — cubit computes it after area selection
    );
  }
}