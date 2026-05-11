import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movin/domain/entities/area_score.dart';
import 'package:movin/domain/entities/property_entity.dart';

class AreaScoreModel extends AreaScore {
  AreaScoreModel({
    required String name,
    required LatLng center,
    required int listingCount,
    double distanceKm = 0,
    List<PropertyEntity> listings = const [],
  }) : super(
         name: name,
         center: center,
         listingCount: listingCount,
         distanceKm: distanceKm,
         listings: listings,
       );

  factory AreaScoreModel.fromJson(Map<String, dynamic> json) {
    return AreaScoreModel(
      name: json['name'] as String,
      center: LatLng(
        (json['lat'] as num).toDouble(),
        (json['lng'] as num).toDouble(),
      ),
      listingCount: json['listing_count'] as int,
      
    );
  }
}
