
class PropertyEntity {
  final String id;
  final String title;
  final String location;
  final String description;
  final int price;
  final String listingType;
  final String type;
  final int size;

  final List<String> images;

  String status;

  final Map<String, dynamic> details;

  final bool isAuction;

  final double? latitude;
  final double? longitude;

  final Map<String, dynamic>? auction;

  final int views;

  final String sellerId;
  final String sellerName;
  final String sellerPhone;
  final String sellerLocation;

  final DateTime? createdAt;

  PropertyEntity({
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
    required this.details,
    required this.isAuction,
    this.latitude,
    this.longitude,
    this.auction,
    required this.views,
    required this.sellerId,
    required this.sellerName,
    required this.sellerPhone,
    required this.sellerLocation,
    this.createdAt,
  });
}
