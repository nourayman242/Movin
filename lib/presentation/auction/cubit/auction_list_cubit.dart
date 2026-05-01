import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/data/api_services/auction_list_services.dart';
import 'package:movin/data/models/auction_list_model.dart';
import 'package:movin/data/models/auction_summary_model.dart';

abstract class AuctionListState {}

class AuctionListInitial extends AuctionListState {}

class AuctionListLoading extends AuctionListState {}

class AuctionListLoaded extends AuctionListState {
  final List<AuctionListModel> auctions;
  final AuctionSummary summary;
  AuctionListLoaded(this.auctions, this.summary);
}

class AuctionListError extends AuctionListState {
  final String message;
  AuctionListError(this.message);
}

class AuctionListCubit extends Cubit<AuctionListState> {
  final AuctionListService service;

  AuctionListCubit(this.service) : super(AuctionListInitial());

  Future<void> loadAuctions({int page = 1, int limit = 10}) async {
  emit(AuctionListLoading());
  try {
    final result = await service.getAuctions(page: page, limit: limit);

    final auctions = result.$1;
    final summary = result.$2;

    emit(AuctionListLoaded(auctions, summary));
  } catch (e) {
    emit(AuctionListError(e.toString()));
  }
}
}
