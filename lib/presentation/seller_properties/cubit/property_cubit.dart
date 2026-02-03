// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movin/data/models/property_request_dto.dart';
// import 'package:movin/domain/entities/property_model.dart';
// import 'package:movin/domain/repositories/property_repository.dart';
// import 'package:movin/presentation/seller_properties/cubit/property_state.dart';

// class PropertyCubit extends Cubit<PropertyState> {
//   final PropertyRepository repo;

//   PropertyCubit(this.repo) : super(PropertyInitial());

//   Future<void> loadProperties() async {
//     emit(PropertyLoading());
//     try {
//       final list = await repo.getAllProperties();
//       emit(PropertyLoaded(list.cast<PropertyModel>()));
//     } catch (e) {
//       emit(PropertyError(e.toString()));
//     }
//   }

//   Future<void> createProperty(PropertyRequest request) async {
//     try {
//       await repo.createProperty(request);
//       loadProperties();
//     } catch (e) {
//       emit(PropertyError(e.toString()));
//     }
//   }

//   Future<void> updateProperty(String id, Map<String, dynamic> data) async {
//     try {
//       await repo.updateProperty(id, data);
//       loadProperties();
//     } catch (e) {
//       emit(PropertyError(e.toString()));
//     }
//   }

//   Future<void> deleteProperty(String id) async {
//     try {
//       await repo.deleteProperty(id);
//       loadProperties();
//     } catch (e) {
//       emit(PropertyError(e.toString()));
//     }
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/data/api_services/property_services.dart';
import 'package:movin/data/api_services/upload_service.dart';
import 'package:movin/presentation/seller_properties/add_property/add_property_viewmodel.dart';

part 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  final UploadService uploadService;
  final PropertyService propertyService;

  PropertyCubit(
    this.uploadService,
    this.propertyService,
  ) : super(PropertyInitial());

  Future<void> addProperty({
    required AddPropertyViewModel vm,
  }) async {
    emit(PropertyLoading());

    try {
      // 1️⃣ upload images
      final imageUrls = await uploadService.uploadImages(vm.images);

      // 2️⃣ create entity
      final entity = vm.toEntity(imageUrls: imageUrls);

      // 3️⃣ send property
      await propertyService.createProperty(entity);

      emit(PropertySuccess());
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }
}

