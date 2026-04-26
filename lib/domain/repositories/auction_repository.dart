abstract class AuctionRepository {
  void connect();
  void joinAuction(String propertyId);
  void placeBid({
    required String propertyId,
    required String userId,
    int? amount,
    int? increment,
    int? percent,
  });

  void listenAuctionData(Function(dynamic) onData);
  void listenNewBid(Function(dynamic) onData);
  void listenAuctionEnded(Function(dynamic) onData);
  void listenAuctionExtended(Function(dynamic) onData);
  void listenBidError(Function(dynamic) onError);

  void dispose();
}
