class PropertyEntity {
  final String id;
  final String location;
  final String description;
  final int price;
  final String listingType;
  final String type;
  final String size;
  final List<String> images;
   String status;
  final Map<String, dynamic> details;

  PropertyEntity({
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "location": location,
    "description": description,
    "price": price,
    "listingType": listingType,
    "type": type,
    "size": size,
    "images": images,
    "status": status,
    "details": details,
  };
}
