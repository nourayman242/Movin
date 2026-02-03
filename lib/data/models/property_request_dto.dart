class PropertyRequest {
  final String location;
  final String description;
  final int price;
  final String type;
  final String size;
  final int bedrooms;
  final int bathrooms;
  final String availableFrom;
  final List<String> images;
  final String paymentMethod;

  PropertyRequest({
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
  });

  Map<String, dynamic> toJson() {
    return {
      "location": location,
      "description": description,
      "price": price,
      "type": type,
      "size": size,
      "bedrooms": bedrooms,
      "bathrooms": bathrooms,
      "available_from": availableFrom,
      "images": images,
      "payment_method": paymentMethod,
    };
  }
}
