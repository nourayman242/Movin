import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/data/models/property_model.dart';
import 'package:movin/domain/repositories/property_repository.dart';
import 'package:movin/presentation/seller_properties/add_property/add_property_viewmodel.dart';

part 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final PropertyRepository repository;

  PropertyCubit(this.repository) : super(PropertyInitial());
  List<PropertyEntity> recentProperties = [];
  List<PropertyEntity> recommendedProperties = [];
  bool loadingRecent = false;
  bool loadingRecommended = false;

  // GET ALL SELLER PROPERTIES

  Future<void> getAllSellerProperties() async {
    emit(PropertyLoading());
    try {
      final properties = await repository.getAll();
      emit(PropertyLoaded(properties));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  // ADD PROPERTY

  Future<void> addProperty(AddPropertyViewModel vm) async {
    try {
      emit(PropertyLoading());

      final token = await SharedHelper.getToken();

      await repository.create(vm, token!);

      final properties = await repository.getAll();

      emit(PropertyLoaded(properties));
    } catch (e) {
      if (e is DioException) {
        final responseData = e.response?.data;

        String errorMessage = 'Server error';

        if (responseData is Map<String, dynamic>) {
          errorMessage = responseData['message'] ?? errorMessage;
        } else if (responseData is String) {
          errorMessage = responseData;
        } else {
          errorMessage = e.message ?? errorMessage;
        }

        emit(PropertyError(errorMessage));
      } else {
        emit(PropertyError(e.toString()));
      }
    }
  }
  // DELETE PROPERTY

  Future<void> deleteProperty(String id) async {
    try {
      await repository.delete(id);
      await getAllSellerProperties();
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  // UPDATE PROPERTY

  // Future<void> updateProperty({
  //   required String id,
  //   required PropertyEntity entity,
  // }) async {
  //   try {
  //     await repository.update(id, entity);
  //     await getAllSellerProperties();
  //   } catch (e) {
  //     emit(PropertyError(e.toString()));
  //   }
  // }
  Future<void> updateProperty({
    required String id,
    required PropertyEntity entity,
  }) async {
    try {
      emit(PropertyLoading());

      await repository.update(id, entity);

      final properties = await repository.getAll();

      emit(PropertyLoaded(properties));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  Future<void> loadRecentProperties() async {
    loadingRecent = true;
    emit(PropertyLoading());

    try {
      recentProperties = await repository.getRecentProperties();
      emit(PropertySuccess());
    } catch (e) {
      emit(PropertyError(e.toString()));
    }

    loadingRecent = false;
  }

  Future<void> loadRecommendedProperties() async {
    loadingRecommended = true;
    emit(PropertyLoading());

    try {
      recommendedProperties = await repository.getRecommendedProperties();
      emit(PropertySuccess());
    } catch (e) {
      emit(PropertyError(e.toString()));
    }

    loadingRecommended = false;
  }
}
