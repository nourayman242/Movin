import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/repositories/property_repository.dart';

part 'create_auction_state.dart';

@injectable
class CreateAuctionCubit extends Cubit<CreateAuctionState> {
  final PropertyRepository repo;

  CreateAuctionCubit(this.repo) : super(CreateAuctionInitial());

  Future<void> createAuction({
    required String propertyId,
    required int startPrice,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    emit(CreateAuctionLoading());

    try {
      await repo.createAuction(
        propertyId: propertyId,
        startPrice: startPrice,
        startTime: startTime.toUtc().toIso8601String(),
        endTime: endTime.toUtc().toIso8601String(),
      );

      emit(CreateAuctionSuccess());
    } catch (e) {
      emit(CreateAuctionError(e.toString()));
    }
  }
}