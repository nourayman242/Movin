import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/presentation/property_evaluation/managers/poperty_evaluation_bloc/prpoerty_evaluation_event.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../data/models/prediction_request_model.dart';
import '../../../../domain/repositories/property_evaluation_repository.dart';

import 'property_evaluation_state.dart';

@injectable
class PropertyEvaluationBloc
    extends Bloc<PropertyEvaluationEvent, PropertyEvaluationState> {
  final PropertyEvaluationRepository repository;

  PropertyEvaluationBloc(this.repository)
    : super(const PropertyEvaluationState()) {
    on<GetPropertyMetadataEvent>(_getMetadata);

    on<UpdateMainAreaEvent>(_updateMainArea);

    on<UpdatePropertyTypeEvent>(_updatePropertyType);

    on<UpdateSubAreaEvent>(_updateSubArea);

    on<UpdatePaymentEvent>(_updatePayment);

    on<PredictPropertyPriceEvent>(_predictPrice);
  }

  Future<void> _getMetadata(
    GetPropertyMetadataEvent event,
    Emitter<PropertyEvaluationState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingMetadata: true));

      final metadata = await repository.getMetadata();

      emit(state.copyWith(loadingMetadata: false, metadata: metadata));
    } catch (e) {
      emit(
        state.copyWith(
          loadingMetadata: false,

          error: ErrorHandler.handle(e).message,
        ),
      );
    }
  }

  void _updatePropertyType(
    UpdatePropertyTypeEvent event,
    Emitter<PropertyEvaluationState> emit,
  ) {
    emit(state.copyWith(selectedType: event.type));
  }

  void _updateSubArea(
    UpdateSubAreaEvent event,
    Emitter<PropertyEvaluationState> emit,
  ) {
    emit(state.copyWith(selectedSubArea: event.subArea));
  }

  void _updatePayment(
    UpdatePaymentEvent event,
    Emitter<PropertyEvaluationState> emit,
  ) {
    emit(state.copyWith(selectedPayment: event.payment));
  }

  void _updateMainArea(
    UpdateMainAreaEvent event,
    Emitter<PropertyEvaluationState> emit,
  ) {
    final areas = state.metadata?.areas[event.mainArea] ?? [];

    emit(
      state.copyWith(
        selectedMainArea: event.mainArea,
        subAreas: areas,
        selectedSubArea: null,
      ),
    );
  }

  Future<void> _predictPrice(
    PredictPropertyPriceEvent event,
    Emitter<PropertyEvaluationState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingPrediction: true, error: null));

      final request = PredictionRequestModel(
        sizeSqm: int.parse(event.size),

        bedroomNum: int.parse(event.bedrooms),

        bathroomsNumeric: int.parse(event.bathrooms),

        isLand: state.selectedType == 'Land' ? 1 : 0,

        isCash: state.selectedPayment == 'Cash' ? 1 : 0,

        mainArea: state.selectedMainArea ?? '',

        type: state.selectedType ?? '',

        subArea: state.selectedSubArea ?? '',
      );

      final response = await repository.predictPrice(request);

      emit(
        state.copyWith(
          loadingPrediction: false,

          predictedPrice: response.predictedPrice,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingPrediction: false,

          error: ErrorHandler.handle(e).message,
        ),
      );
    }
  }
}
