class PropertyEntity {
  final String location;
  final String description;
  final int price;
  final String type;
  final String size;
  final int? bedrooms;
  final int? bathrooms;
  final DateTime availableFrom;
  final List<String> images; // URLs
  final String paymentMethod;

  PropertyEntity({
    required this.location,
    required this.description,
    required this.price,
    required this.type,
    required this.size,
    this.bedrooms,
    this.bathrooms,
    required this.availableFrom,
    required this.images,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() => {
        "location": location,
        "description": description,
        "price": price,
        "type": type,
        "size": size,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "available_from": availableFrom.toIso8601String(),
        "images": images,
        "payment_method": paymentMethod,
      };
}
