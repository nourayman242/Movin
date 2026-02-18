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

  // factory PropertyModel.fromJson(Map<String, dynamic> json) {
  //   List<String> parsedImages = [];

  //   if (json['images'] != null && json['images'] is List) {
  //     final rawImages = json['images'] as List;

  //     parsedImages = rawImages
  //         .map<String>((img) {
  //           if (img is String) {
  //             return img;
  //           } else if (img is Map<String, dynamic>) {
  //             return img['url']?.toString() ?? '';
  //           }
  //           return '';
  //         })
  //         .where((e) => e.isNotEmpty)
  //         .toList();
  //   }

  //   return PropertyModel(
  //     id: json['_id']?.toString() ?? '',
  //     location: json['location'] ?? '',
  //     description: json['description'] ?? '',
  //     price: json['price'] is int
  //         ? json['price']
  //         : int.tryParse(json['price'].toString()) ?? 0,
  //     type: json['type'] ?? '',
  //     size: json['size'] ?? '',
  //     bedrooms: json['bedrooms'] ?? 0,
  //     bathrooms: json['bathrooms'] ?? 0,
  //     availableFrom:
  //         DateTime.tryParse(json['available_from'] ?? '') ?? DateTime.now(),
  //     images: parsedImages,
  //     paymentMethod: json['payment_method'] ?? '',
  //     status: json['status'] ?? '',
  //   );
  // }
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    final List<String> parsedImages = [];

    final imagesRaw = json['images'];

    print("RAW IMAGES VALUE: $imagesRaw");
    print("RAW IMAGES TYPE: ${imagesRaw.runtimeType}");

    if (imagesRaw is List) {
      for (final img in imagesRaw) {
        print("IMG ITEM: $img | TYPE: ${img.runtimeType}");

        // Case 1: already a full URL string
        if (img is String && img.startsWith('http')) {
          parsedImages.add(img);
        }
        // Case 2: filename string (img4.jpg)
        else if (img is String) {
          parsedImages.add(
            "https://movin-oipd650to-malakkhaled22s-projects.vercel.app/uploads/$img",
          );
        }
        // Case 3: map with url key (Cloudinary)
        else if (img is Map && img.containsKey('url')) {
          parsedImages.add(img['url'].toString());
        }
      }
    }

    print("PARSED IMAGES FINAL: $parsedImages");
    print("MODEL RECEIVED IMAGES RAW: ${json['images']}");
    print("MODEL PARSED IMAGES: $parsedImages");

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
