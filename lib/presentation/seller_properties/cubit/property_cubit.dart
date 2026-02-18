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
    emit(PropertyLoading());
    try {
      final token = await SharedHelper.getToken();

      await repository.create(vm, token!);

      await getAllSellerProperties();

      emit(PropertySuccess());
     } 
    //  catch (e) {
    //   emit(PropertyError(e.toString()));
    // }
    catch (e) {
      if (e is DioException) {
        emit(
          PropertyError(
            e.response?.data['message'] ?? e.message ?? 'Server error',
          ),
        );
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

  Future<void> updateProperty({
    required String id,
    required PropertyEntity entity,
  }) async {
    try {
      await repository.update(id, entity);
      await getAllSellerProperties();
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }
}
