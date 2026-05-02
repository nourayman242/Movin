class PropertyModel {
  final String id;
  final String title;
  final String location;
  final String image;
  final String tag;
  final String price; // formatted string (kept for UI display)
  final int beds;
  final int baths;
  final int sqft;

  // ── Fields added for filter/sort support ──────────────────────────────────
  final int rawPrice;       // numeric price for Price sort
  final int views;          // for Most Popular sort
  final DateTime? createdAt; // for Newest First sort
  final String type;        // e.g. "villa", "apartment"
  final String listingType; // "sale" or "rent"
  final String status;
  final List<String> images; // full image list from API
  final Map<String, dynamic> details; // bedrooms, bathrooms, pool, furnished…

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
    // new fields — all have safe defaults so existing code won't break
    this.rawPrice = 0,
    this.views = 0,
    DateTime? createdAt,
    this.type = '',
    this.listingType = 'sale',
    this.status = '',
    this.images = const [],
    this.details = const {},
  }) : createdAt = createdAt ?? DateTime(2000);

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    // ── Images ───────────────────────────────────────────────────────────────
    // API returns a list of objects: [{ "url": "...", "public_id": "..." }]
    final rawImages = json['images'] as List<dynamic>? ?? [];
    final imageUrls = rawImages
        .map((img) {
          if (img is Map<String, dynamic>) return img['url'] as String?;
          if (img is String) return img;
          return null;
        })
        .whereType<String>()
        .toList();

    final firstImage = imageUrls.isNotEmpty ? imageUrls.first : '';

    // ── Price ─────────────────────────────────────────────────────────────────
    final rawPrice = (json['price'] as num?)?.toInt() ?? 0;
    final formattedPrice = _formatPrice(rawPrice);

    // ── Details map ───────────────────────────────────────────────────────────
    final details = (json['details'] as Map<String, dynamic>?) ?? {};

    final beds =
        int.tryParse(details['bedrooms']?.toString() ?? '') ?? 0;
    final baths =
        int.tryParse(details['bathrooms']?.toString() ?? '') ?? 0;
    final sqft = int.tryParse(
            (details['size'] ?? json['size'])?.toString() ?? '') ??
        0;

    // ── Type → tag ────────────────────────────────────────────────────────────
    final type = json['type'] as String? ?? '';
    final listingType = json['listingType'] as String? ?? 'sale';
    final tag = listingType == 'rent' ? 'For Rent' : 'For Sale';

    return PropertyModel(
      id: json['_id'] as String? ?? '',
      title: json['description'] as String? ?? type,
      location: json['location'] as String? ?? '',
      image: firstImage,
      tag: tag,
      price: formattedPrice,
      beds: beds,
      baths: baths,
      sqft: sqft,
      rawPrice: rawPrice,
      views: (json['views'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String) ?? DateTime(2000)
          : DateTime(2000),
      type: type,
      listingType: listingType,
      status: json['status'] as String? ?? '',
      images: imageUrls,
      details: details,
    );
  }

  static String _formatPrice(int price) {
    if (price >= 1000000) {
      return 'EGP ${(price / 1000000).toStringAsFixed(1)}M';
    } else if (price >= 1000) {
      return 'EGP ${(price / 1000).toStringAsFixed(0)}K';
    }
    return 'EGP $price';
  }
}