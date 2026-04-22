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
  final bool isAuction;
  final String? auctionStatus;

  PropertyModel({
    required this.isAuction,
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
    required this.auctionStatus,
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

    final details = json['details'] is Map<String, dynamic>
        ? json['details']
        : {};
        final auction = json['auction'];
    return PropertyModel(
       isAuction: auction != null
        ? auction['isAuction'] == true
        : false,
        auctionStatus: auction != null ? auction['status'] : null,
      id: json['_id']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      description: json['description']?.toString() ?? '',

      price: json['price'] is int
          ? json['price']
          : int.tryParse(json['price'].toString()) ?? 0,

      listingType: json['listingType']?.toString() ?? '',
      type: json['type']?.toString() ?? '',

      size: details['size']?.toString() ?? '',

      images: parsedImages,
      status: json['status']?.toString() ?? '',

      details: details,
    );
  }
  PropertyEntity toEntity() {
    return PropertyEntity(
      isAuction:isAuction,
      id: id,
      location: location,
      description: description,
      price: price,
      listingType: listingType,
      type: type,
      size: size,
      images: images,
      status: status,
      details: details,
    );
  }
}
