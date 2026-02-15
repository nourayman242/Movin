import 'package:dio/dio.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/data/models/property_model.dart';
import 'package:movin/presentation/seller_properties/add_property/add_property_viewmodel.dart';

class PropertyService {
  final Dio dio;
  PropertyService(this.dio);

  // Future<void> createProperty(PropertyEntity entity) async {
  //   await dio.post('/api/seller/properties/create', data: entity.toJson());
  // }

  // Future<void> createProperty({
  //   required AddPropertyViewModel vm,
  //   required String token,
  // }) async {
  //   final formData = FormData.fromMap({
  //     "location": vm.location,
  //     "description": vm.description,
  //     "price": vm.price,
  //     "type": vm.type,
  //     "size": vm.size,
  //     "bedrooms": vm.bedrooms,
  //     "bathrooms": vm.bathrooms,
  //     "available_from": vm.availableFrom.toIso8601String(),
  //     "payment_method": vm.paymentMethod,
  //   });

  //   // 🔥 images field MUST be "images"
  //   for (final image in vm.images) {
  //     formData.files.add(
  //       MapEntry(
  //         "images",
  //         await MultipartFile.fromFile(image.path, filename: image.name),
  //       ),
  //     );
  //   }

  //   await dio.post(
  //     "/api/seller/properties/create",
  //     data: formData,
  //     options: Options(
  //       contentType: "multipart/form-data",
  //       headers: {"Authorization": "Bearer $token"},
  //     ),
  //   );
  // }
  //   Future<void> createProperty({
  //     required AddPropertyViewModel vm,
  //     required String token,
  //   }) async {
  //     final formData = FormData.fromMap({
  //       "location": vm.location,
  //       "description": vm.description,
  //       "price": vm.price.toString(),
  //       "type": vm.type,
  //       "size": vm.size,
  //       "bedrooms": vm.bedrooms.toString(),
  //       "bathrooms": vm.bathrooms.toString(),
  //       "available_from": vm.availableFrom.toIso8601String(),
  //       "payment_method": vm.paymentMethod,
  //     });

  //     for (final image in vm.images) {
  //       formData.files.add(
  //         MapEntry(
  //           "images",
  //           await MultipartFile.fromFile(image.path, filename: image.name),
  //         ),
  //       );
  //     }

  //     await dio.post(
  //       "/api/seller/properties/create",
  //       data: formData,
  //       options: Options(headers: {"Authorization": "Bearer $token"}),
  //     );

  //     dio.interceptors.add(
  //   LogInterceptor(
  //     request: true,
  //     requestBody: true,
  //     responseBody: true,
  //     error: true,
  //   ),
  // );
  //   }
  // Future<void> createProperty({
  //   required AddPropertyViewModel vm,
  //   required String token,
  // }) async {
  //   final formData = FormData();

  //   formData.fields.addAll([
  //     MapEntry("location", vm.location),
  //     MapEntry("description", vm.description),
  //     MapEntry("price", vm.price.toString()),
  //     MapEntry("type", vm.type),
  //     MapEntry("size", vm.size),
  //     MapEntry("bedrooms", vm.bedrooms.toString()),
  //     MapEntry("bathrooms", vm.bathrooms.toString()),
  //     MapEntry("available_from", vm.availableFrom.toIso8601String()),
  //     MapEntry("payment_method", vm.paymentMethod),
  //   ]);

  //   for (final image in vm.images) {
  //     formData.files.add(
  //       MapEntry(
  //         "images",
  //         await MultipartFile.fromFile(
  //           image.path,
  //           filename: image.name,
  //         ),
  //       ),
  //     );
  //   }

  //   await dio.post(
  //     "/api/seller/properties/create",
  //     data: formData,
  //     options: Options(
  //       headers: {
  //         "Authorization": "Bearer $token",
  //       },
  //     ),
  //   );
  // }

  Future<void> createProperty({
    required AddPropertyViewModel vm,
    required String token,
  }) async {
    final formData = FormData.fromMap({
      "location": vm.location,
      "description": vm.description,
      "price": vm.price.toString(),
      "type": vm.type,
      "size": vm.size ?? "",
      "bedrooms": vm.bedrooms.toString(),
      "bathrooms": vm.bathrooms.toString(),
      "available_from": vm.availableFrom.toIso8601String(),
      "payment_method": vm.paymentMethod,
    });

    for (final image in vm.images) {
      formData.files.add(
        MapEntry(
          "images",
          await MultipartFile.fromFile(image.path, filename: image.name),
        ),
      );
    }

    await dio.post(
      "/api/seller/properties/create",
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
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
    await dio.patch('/api/seller/properties/$id', data: entity.toJson());
  }
  // Future<void> updateProperty({
  //   required String id,
  //   required AddPropertyViewModel vm,
  //   required String token,
  // }) async {
  //   final formData = FormData.fromMap({
  //     "location": vm.location,
  //     "description": vm.description,
  //     "price": vm.price.toString(),
  //     "available_from": vm.availableFrom.toIso8601String(),
  //   });

  //   for (final image in vm.images) {
  //     formData.files.add(
  //       MapEntry("images", await MultipartFile.fromFile(image.path)),
  //     );
  //   }

  //   await dio.patch(
  //     "/api/seller/properties/$id",
  //     data: formData,
  //     options: Options(headers: {"Authorization": "Bearer $token"}),
  //   );
  // }

  Future<void> deleteProperty(String id) async {
    await dio.delete('/api/seller/properties/$id');
  }
}
