
class PropertyEntity {
  final String location;
  final String description;
  final int price;
  final String listingType;
  final String type;
  final String size;
  final List<String> images;
  final Map<String, dynamic> details;

  PropertyEntity({
    required this.location,
    required this.description,
    required this.price,
    required this.listingType,
    required this.type,
    required this.size,
    required this.images,
    required this.details,
  });

  Map<String, dynamic> toJson() => {
        "location": location,
        "description": description,
        "price": price,
        "listingType": listingType,
        "type": type,
        "size": size,
        "images": images,
        "details": details,
      };
}
