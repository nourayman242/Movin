class AuctionSummary {
  final int activeAuctions;
  final int endingSoon;
  final int totalBids;

  AuctionSummary({
    required this.activeAuctions,
    required this.endingSoon,
    required this.totalBids,
  });

  factory AuctionSummary.fromJson(Map<String, dynamic> json) {
    return AuctionSummary(
      activeAuctions: json['activeAuctions'] ?? 0,
      endingSoon: json['endingSoon'] ?? 0,
      totalBids: json['totalBids'] ?? 0,
    );
  }
}