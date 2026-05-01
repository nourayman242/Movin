import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/domain/repositories/property_repository.dart';
import 'package:movin/presentation/seller_properties/saller%20home/cubit/most_viewed_state.dart';



@injectable
class MostviewedCubit extends Cubit<MostviewedState> {
  final PropertyRepository repo;

  MostviewedCubit(this.repo) : super(MostviewedInitial());

  List<PropertyEntity> mostViewedProperties = [];

  Future<void> getMostViewedProperties() async {
    emit(MostViewedLoading());

    try {
      mostViewedProperties = await repo.getMostViewedProperties();
      emit(MostViewedLoaded(mostViewedProperties));
    } catch (e) {
      emit(MostViewedError(e.toString()));
    }
  }
}