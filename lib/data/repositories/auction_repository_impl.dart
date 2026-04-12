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
  void placeBid({
    required String propertyId,
    required String userId,
    int? amount,
    int? increment,
    int? percent,
  }) {
    final Map<String, dynamic> data = {
      "propertyId": propertyId,
      "userId": userId,
    };

    if (amount != null) {
      data["amount"] = amount;
    } else if (increment != null) {
      data["increment"] = increment;
    } else if (percent != null) {
      data["percent"] = percent;
    }

    socketService.socket.emit("placeBid", data);
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
void listenBidError(Function(dynamic) onError) {
  socketService.socket.on("bidError", onError);
}

  @override
  void dispose() {
    socketService.socket.off("auctionData");
    socketService.socket.off("newBid");
    socketService.socket.off("auctionExtended");
    socketService.socket.off("auctionEnded");
  }
}
