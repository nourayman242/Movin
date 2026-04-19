import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/area_score.dart';

class AreaScoreModel extends AreaScore {
  AreaScoreModel({
    required String name,
    required LatLng center,
    required double score,
    required int listingCount,
  }) : super(
          name: name,
          center: center,
          score: score,
          listingCount: listingCount,
        );

  factory AreaScoreModel.fromJson(Map<String, dynamic> json) {
    return AreaScoreModel(
      name: json['name'],
      center: LatLng(json['lat'], json['lng']),
      score: (json['score'] as num).toDouble(),
      listingCount: json['listing_count'],
    );
  }
}