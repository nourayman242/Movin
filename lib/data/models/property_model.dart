class PropertyModel {
  final String id;
  final String location;
  final String description;
  final int price;
  final String type;
  final String size;
  final int bedrooms;
  final int bathrooms;
  final DateTime availableFrom;
  final List<String> images;
  final String paymentMethod;
  final String status;

  PropertyModel({
    required this.id,
    required this.location,
    required this.description,
    required this.price,
    required this.type,
    required this.size,
    required this.bedrooms,
    required this.bathrooms,
    required this.availableFrom,
    required this.images,
    required this.paymentMethod,
    required this.status,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedImages = [];

    if (json['images'] != null && json['images'] is List) {
      final rawImages = json['images'] as List;

      parsedImages = rawImages
          .map<String>((img) {
            if (img is String) {
              return img;
            } else if (img is Map<String, dynamic>) {
              return img['url']?.toString() ?? '';
            }
            return '';
          })
          .where((e) => e.isNotEmpty)
          .toList();
    }

    return PropertyModel(
      id: json['_id']?.toString() ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] is int
          ? json['price']
          : int.tryParse(json['price'].toString()) ?? 0,
      type: json['type'] ?? '',
      size: json['size'] ?? '',
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      availableFrom:
          DateTime.tryParse(json['available_from'] ?? '') ?? DateTime.now(),
      images: parsedImages,
      paymentMethod: json['payment_method'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
