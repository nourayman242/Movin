import 'package:movin/domain/entities/property_entity.dart';

class PropertyModel {
  final String id;
  final String title;
  final String location;
  final String description;
  final int price;
  final String listingType;
  final String type;
  final int size;
  final List<String> images;
  final String status;
  final Map<String, dynamic> details;
  final bool isAuction;

  final double? latitude;
  final double? longitude;

  final String? auctionStatus;
  final Map<String, dynamic>? auction;
  final String sellerId;
  final String sellerName;
  final String sellerPhone;
  final String sellerLocation;
  final int views;

  //time
  final DateTime? createdAt;

  PropertyModel({
    required this.isAuction,
    required this.id,
    required this.title,
    required this.location,
    required this.description,
    required this.price,
    required this.listingType,
    required this.type,
    required this.size,
    required this.images,
    required this.status,
    this.auction,
    required this.details,
    this.latitude,
    this.longitude,
    required this.auctionStatus,
    required this.sellerId,
    required this.sellerName,
    required this.sellerPhone,
    required this.sellerLocation,
    required this.views,

    //time
    this.createdAt,
  });
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> safeMap(dynamic data) {
      return data is Map
          ? Map<String, dynamic>.from(data)
          : <String, dynamic>{};
    }

    List<String> parsedImages = [];

    // ✅ SAFE images
    if (json['images'] is List) {
      for (final img in json['images']) {
        if (img is Map) {
          parsedImages.add(img['url']?.toString() ?? '');
        } else if (img is String) {
          parsedImages.add(img);
        }
      }
    }

    // ✅ SAFE maps (THIS IS WHAT FIXES YOUR ERROR)
    final details = safeMap(json['details']);
    final auction = safeMap(json['auction']);
    final seller = safeMap(json['seller']);
    return PropertyModel(
      id: json['_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: int.tryParse(json['price'].toString()) ?? 0,
      listingType: json['listingType']?.toString() ?? '',
      type: json['type']?.toString() ?? '',

      size: int.tryParse(json['size'].toString()) ?? 0,

      images: parsedImages,

      status: json['status']?.toString() ?? '',

      details: details,

      isAuction: auction['isAuction'] == true,

      latitude: json['coordinates']?['latitude']?.toDouble(),
      longitude: json['coordinates']?['longitude']?.toDouble(),

      auctionStatus: auction['status']?.toString(),
      auction: auction,

      sellerId: seller['_id']?.toString() ?? '',
      sellerName: seller['username']?.toString() ?? '',
      sellerPhone: seller['phone']?.toString() ?? '',
      sellerLocation: seller['location']?.toString() ?? '',

      views: int.tryParse(json['views'].toString()) ?? 0,

      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  PropertyEntity toEntity() {
    return PropertyEntity(
      id: id,
      title: title,
      location: location,
      description: description,
      price: price,
      listingType: listingType,
      type: type,
      size: size,
      images: images,
      status: status,
      details: details,
      isAuction: isAuction,
      latitude: latitude,
      longitude: longitude,
      auction: {"status": auctionStatus},
      sellerId: sellerId,
      sellerName: sellerName,
      sellerPhone: sellerPhone,
      sellerLocation: sellerLocation,
      views: views,
      createdAt: createdAt,
    );
  }
}
