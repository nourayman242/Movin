import 'package:movin/data/api_services/socket_service.dart';
import 'package:movin/domain/repositories/auction_repository.dart';

class AuctionRepositoryImpl implements AuctionRepository {
  final SocketService socketService;

  AuctionRepositoryImpl(this.socketService);

  @override
  void connect() {
    socketService.connect();
  }

  @override
  void joinAuction(String propertyId) {
    socketService.socket.emit("joinAuction", propertyId);
  }

  @override
  void placeBid(String propertyId, int amount, String userId) {
    socketService.socket.emit("placeBid", {
      "propertyId": propertyId,
      "amount": amount,
      "userId": userId,
    });
  }

  @override
  void listenAuctionData(Function(dynamic p1) onData) {
    socketService.socket.on("auctionData", onData);
  }

  @override
  void listenNewBid(Function(dynamic p1) onData) {
    socketService.socket.on("newBid", onData);
  }

  @override
  void listenAuctionExtended(Function(dynamic p1) onData) {
    socketService.socket.on("auctionExtended", onData);
  }

  @override
  void listenAuctionEnded(Function(dynamic p1) onData) {
    socketService.socket.on("auctionEnded", onData);
  }

  @override
  void dispose() {
    socketService.socket.off("auctionData");
    socketService.socket.off("newBid");
    socketService.socket.off("auctionExtended");
    socketService.socket.off("auctionEnded");
  }
}
