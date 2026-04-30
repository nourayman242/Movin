part of 'create_auction_cubit.dart';

abstract class CreateAuctionState {}

class CreateAuctionInitial extends CreateAuctionState {}

class CreateAuctionLoading extends CreateAuctionState {}

class CreateAuctionSuccess extends CreateAuctionState {}

class CreateAuctionError extends CreateAuctionState {
  final String message;
  CreateAuctionError(this.message);
}