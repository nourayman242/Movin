class AuctionSeller {
  final String id;
  final String username;

  AuctionSeller({required this.id, required this.username});

  factory AuctionSeller.fromJson(Map<String, dynamic> json) {
    return AuctionSeller(
      id: json['_id'] ?? '',
      username: json['username'] ?? '',
    );
  }
}

class AuctionListModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String? image;
  final double startPrice;
  final double currentBid;
  final int totalBids;
  final String endTime;
  final String status;
  final AuctionSeller seller;
  final String type;
  final String listingType;
  final double size;
  final int views;
  Map<String, dynamic> details;

  AuctionListModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    this.image,
    required this.startPrice,
    required this.currentBid,
    required this.totalBids,
    required this.endTime,
    required this.status,
    required this.seller,
    required this.type,
    required this.listingType,
    required this.size,
    required this.views,
    required this.details,
  });

  factory AuctionListModel.fromJson(Map<String, dynamic> json) {
    print("TITLE => ${json['title']}");
print("DETAILS => ${json['details']}");
    return AuctionListModel(
      id: json['_id'] ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      image: json['image'],
      startPrice: (json['startPrice'] ?? 0).toDouble(),
      currentBid: (json['currentBid'] ?? 0).toDouble(),
      totalBids: json['totalBids'] ?? 0,
      endTime: json['endTime'] ?? '',
      status: json['status'] ?? '',
      seller: AuctionSeller.fromJson(json['seller'] ?? {}),
      type: json['type'] ?? '',
      listingType: json['listingType'] ?? '',
      size: (json['size'] ?? 0).toDouble(),
      views: json['views'] ?? 0,
      details: json['details'] != null
    ? Map<String, dynamic>.from(json['details'])
    : {},
    );
    
  }
}
