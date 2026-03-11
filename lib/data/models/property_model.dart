
import 'package:movin/domain/entities/property_entity.dart';

class PropertyModel {
  final String id;
  final String location;
  final String description;
  final int price;
  final String listingType;
  final String type;
  final String size;
  final List<String> images;
  final String status;
  final Map<String, dynamic> details;

  PropertyModel({
    required this.id,
    required this.location,
    required this.description,
    required this.price,
    required this.listingType,
    required this.type,
    required this.size,
    required this.images,
    required this.status,
    required this.details,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    final List<String> parsedImages = [];

    if (json['images'] is List) {
      for (final img in json['images']) {
        if (img is Map && img.containsKey('url')) {
          parsedImages.add(img['url']);
        }
      }
    }

    return PropertyModel(
      id: json['_id'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      listingType: json['listingType'] ?? '',
      type: json['type'] ?? '',
      size: json['size'] ?? '',
      images: parsedImages,
      status: json['status'] ?? '',
      details: json['details'] ?? {},
    );
  }
  PropertyEntity toEntity() {
    return PropertyEntity(
      id: id,
      location: location,
      description: description,
      price: price,
      listingType: listingType,
      type: type,
      size: size,
      images: images,
      status:status,
      details: details,
    );
  }
}

