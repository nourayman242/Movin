class PropertyModel {
  final String id;
  final String title;
  final String location;
  final String image;
  final String tag;
  final String price; // format
  final int beds;
  final int baths;
  final int sqft;
  bool isfavorite;

  PropertyModel({
    required this.id,
    required this.title,
    required this.location,
    required this.image,
    required this.tag,
    required this.price,
    required this.beds,
    required this.baths,
    required this.sqft,
    this.isfavorite = false,
  });
}
