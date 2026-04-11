import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/domain/repositories/auction_repository.dart';

class AuctionState {
  final int currentBid;
  final int totalBids;
  final String status;
  final String endTime;
  final List bids;
  final int startPrice;

  AuctionState({
    this.startPrice = 0,
    this.currentBid = 0,
    this.totalBids = 0,
    this.status = "live",
    this.endTime = "",
    this.bids = const [],
  });

  AuctionState copyWith({
    int? startPrice,
    int? currentBid,
    int? totalBids,
    String? status,
    String? endTime,
    List? bids,
  }) {
    return AuctionState(
      startPrice: startPrice ?? this.startPrice,
      currentBid: currentBid ?? this.currentBid,
      totalBids: totalBids ?? this.totalBids,
      status: status ?? this.status,
      endTime: endTime ?? this.endTime,
      bids: bids ?? this.bids,
    );
  }
}

class AuctionCubit extends Cubit<AuctionState> {
  final AuctionRepository repo;

  AuctionCubit(this.repo) : super(AuctionState());

 
  void init(String propertyId) {
    repo.connect();
    repo.joinAuction(propertyId);

    repo.listenAuctionData((data) {
      print("auctionData: $data"); 

      emit(
        state.copyWith(
          currentBid: data["currentBid"] ?? 0,
          totalBids: data["totalBids"] ?? 0,
          endTime: data["endTime"] ?? "",
          status: data["status"] ?? "live",
          bids: data["bids"] ?? [],
        ),
      );
    });

    repo.listenNewBid((data) {
      print("newBid: $data");

      final newBids = List.from(state.bids)..insert(0, data["bid"]);

      emit(
        state.copyWith(
          currentBid: data["currentBid"] ?? state.currentBid,
          totalBids: data["totalBids"] ?? state.totalBids,
          endTime: data["endTime"] ?? state.endTime,
          status: data["status"] ?? state.status,
          bids: newBids,
        ),
      );
    });

    repo.listenAuctionExtended((data) {
      emit(state.copyWith(endTime: data["endTime"], status: data["status"]));
    });

    repo.listenAuctionEnded((data) {
      emit(state.copyWith(status: "ended"));
    });
  }

  void placeBid(String propertyId, int amount, String userId) {
    repo.placeBid(propertyId, amount, userId);
  }

  @override
  Future<void> close() {
    repo.dispose();
    return super.close();
  }
}
