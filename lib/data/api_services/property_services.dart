import 'package:dio/dio.dart';
import 'package:movin/domain/entities/property_entity.dart';
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

  // Future<void> createProperty(Map<String, dynamic> data) async {
  //   await dio.post(
  //     '/api/seller/properties/create',
  //     data: data,
  //   );
  // }
  Future<void> createProperty(PropertyEntity entity) async {
    await dio.post(
      '/api/seller/properties/create',
      data: entity.toJson(),
    );
  }

  Future<List<dynamic>> getAllProperties() async {
    final res = await dio.get(
      '/api/seller/properties/getAll',
    );
    return res.data['products'];
  }

  Future<void> updateProperty(String id, Map<String, dynamic> data) async {
    await dio.patch(
      '/api/seller/properties/$id',
      data: data,
    );
  }

  Future<void> deleteProperty(String id) async {
    await dio.delete(
      '/api/seller/properties/$id',
    );
  }
}
