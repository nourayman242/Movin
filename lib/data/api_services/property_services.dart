import 'package:dio/dio.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/data/models/property_model.dart';

// class PropertyServices {
//   final Dio dio;

//   PropertyServices(this.dio);

//   // CREATE
//   Future<PropertyModel> createProperty(PropertyRequest request) async {
//     final response = await dio.post(
//       '/api/seller/properties/create',
//       data: request.toJson(),
//     );

//     return PropertyModel.fromJson(response.data['property']);
//   }

//   // GET ALL
//   Future<List<PropertyModel>> getAllProperties() async {
//     final response = await dio.get(
//       '/api/seller/properties/getAll',
//     );

//     return (response.data['products'] as List)
//         .map((e) => PropertyModel.fromJson(e))
//         .toList();
//   }

//   // UPDATE
//   Future<PropertyModel> updateProperty(
//     String id,
//     Map<String, dynamic> data,
//   ) async {
//     final response = await dio.patch(
//       '/api/seller/properties/$id',
//       data: data,
//     );

//     return PropertyModel.fromJson(response.data['product']);
//   }

//   // DELETE
//   Future<void> deleteProperty(String id) async {
//     await dio.delete(
//       '/api/seller/properties/$id',
//     );
//   }
// }




class PropertyService {
  final Dio dio;
  PropertyService(this.dio);

  Future<void> createProperty(PropertyEntity entity) async {
    await dio.post('/api/seller/properties/create', data: entity.toJson());
  }

 Future<List<PropertyModel>> getAllSellerProperties() async {
  final response = await dio.get('/api/seller/properties/getAll');

  if (response.data == null || response.data['products'] == null) {
    return [];
  }

  return (response.data['products'] as List)
      .map((e) => PropertyModel.fromJson(e))
      .toList();
}


  Future<void> updateProperty(String id, PropertyEntity entity) async {
    await dio.put('/api/seller/properties/$id', data: entity.toJson());
  }

  Future<void> deleteProperty(String id) async {
    await dio.delete('/api/seller/properties/$id');
  }
}
