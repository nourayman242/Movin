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
    return PropertyModel(
      id: json['_id'],
      location: json['location'],
      description: json['description'],
      price: json['price'],
      type: json['type'],
      size: json['size'],
      bedrooms: json['bedrooms'],
      bathrooms: json['bathrooms'],
      availableFrom: DateTime.parse(json['available_from']),
      images: List<String>.from(json['images']),
      paymentMethod: json['payment_method'],
      status: json['status'],
    );
  }
   
}
