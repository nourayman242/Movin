abstract class AuctionRepository {
  void joinAuction(String propertyId);
  void placeBid(String propertyId, int amount, String userId);

  void listenAuctionData(Function(dynamic) onData);
  void listenNewBid(Function(dynamic) onData);
  void listenAuctionEnded(Function(dynamic) onData);
  void listenAuctionExtended(Function(dynamic) onData);

  void dispose();
}