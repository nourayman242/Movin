class SellerDashboardStatsModel {
  final int activeListings;
  final int totalViews;
  final int totalFavorites;
  final int auctionListings;

  SellerDashboardStatsModel({
    required this.activeListings,
    required this.totalViews,
    required this.totalFavorites,
    required this.auctionListings,
  });

  factory SellerDashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return SellerDashboardStatsModel(
      activeListings: json['activeListings'] ?? 0,
      totalViews: json['totalViews'] ?? 0,
      totalFavorites: json['totalFavorites'] ?? 0,
      auctionListings: json['auctionListings'] ?? 0,
    );
  }
}