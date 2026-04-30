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

  final double? latitude;
  final double? longitude;

  final String? auctionStatus;
  final String sellerName;
  final String sellerPhone;
  final String sellerLocation;
  final int views;


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
    this.latitude,
    this.longitude,
    required this.auctionStatus,
    required this.sellerName,
    required this.sellerPhone,
    required this.sellerLocation,
    required this.views,

  });
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    final List<String> parsedImages = [];

    // SAFE images parse
    if (json['images'] is List) {
      for (final img in json['images']) {
        if (img is Map<String, dynamic>) {
          parsedImages.add(img['url']?.toString() ?? '');
        } else if (img is String) {
          parsedImages.add(img);
        }
      }
    }

    final details = json['details'] is Map<String, dynamic>
        ? json['details']
        : {};

    final auction = json['auction'] is Map<String, dynamic>
        ? json['auction']
        : {};

    final seller = json['seller'] is Map<String, dynamic> ? json['seller'] : {};

    return PropertyModel(
      id: json['_id']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: int.tryParse(json['price'].toString()) ?? 0,
      listingType: json['listingType']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      size: json['size']?.toString() ?? details['size']?.toString() ?? '',
      images: parsedImages,
      status: json['status']?.toString() ?? '',
      details: details,

      isAuction: auction['isAuction'] == true,
      views: int.tryParse(json['views'].toString()) ?? 0,

      sellerName: seller['username']?.toString() ?? '',
      sellerPhone: seller['phone']?.toString() ?? '',
      sellerLocation: seller['location']?.toString() ?? '',

      auctionStatus: auction['status']?.toString() ?? '',
    );
  }
  PropertyEntity toEntity() {
    return PropertyEntity(
      isAuction: isAuction,
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
      latitude: latitude,
      longitude: longitude,
      sellerName: sellerName,
      sellerPhone: sellerPhone,
      sellerLocation: sellerLocation,
      views: views,
    );
  }
}
