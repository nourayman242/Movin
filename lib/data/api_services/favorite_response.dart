import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/data/models/property_model.dart';

class FavoriteResponse {
  final String message; 

  final List<PropertyEntity> favorites;

  FavoriteResponse({required this.message, required this.favorites});

  factory FavoriteResponse.fromMap(Map<String, dynamic> map) {
    return FavoriteResponse(
      message: map['message'] ?? '',
      favorites: map['favorites'] != null
          ? (map['favorites'] as List)
          .map(
            (e) => PropertyModel.fromJson(e).toEntity(),
      )
          .toList()
          : [],
    );
  }
}