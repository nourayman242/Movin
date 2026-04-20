import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/domain/entities/area_score.dart'; 

class AreaScoreModel extends AreaScore {
  AreaScoreModel({
    required String name,
    required LatLng center,
    required double score,
    required int listingCount,
    double distanceKm = 0,
  }) : super(
          name: name,
          center: center,
          score: score,
          listingCount: listingCount,
          distanceKm: distanceKm,
        );

  factory AreaScoreModel.fromJson(Map<String, dynamic> json) {
    return AreaScoreModel(
      name: json['name'],
      center: LatLng(
        (json['lat'] as num).toDouble(),
        (json['lng'] as num).toDouble(),
      ),
      score: (json['score'] as num).toDouble(),
      listingCount: json['listing_count'] as int,
    );
  }
}