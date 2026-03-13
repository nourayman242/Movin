import 'package:dio/dio.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/domain/entities/property_entity.dart';
import 'package:movin/data/models/property_model.dart';
import 'package:movin/presentation/seller_properties/add_property/add_property_viewmodel.dart';

class PropertyService {
  final Dio dio;
  PropertyService(this.dio);

  Future<void> createProperty({
    required AddPropertyViewModel vm,
    required String token,
  }) async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry("location", vm.location),
      MapEntry("description", vm.description),
      MapEntry("price", vm.price.toString()),
      MapEntry("listingType", vm.listingType),
      MapEntry("type", vm.type),
      MapEntry("size", vm.size),
    ]);

    vm.details.forEach((key, value) {
      formData.fields.add(MapEntry("details[$key]", value.toString()));
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
    final formData = FormData();

    formData.fields.addAll([
      MapEntry("location", entity.location),
      MapEntry("description", entity.description),
      MapEntry("price", entity.price.toString()),
      MapEntry("listingType", entity.listingType),
      MapEntry("type", entity.type),
      MapEntry("size", entity.size),
    ]);

    entity.details.forEach((key, value) {
      formData.fields.add(MapEntry("details[$key]", value.toString()));
    });

    await dio.patch('/api/seller/properties/$id', data: formData);
  }

  Future<void> deleteProperty(String id) async {
    await dio.delete('/api/seller/properties/$id');
  }

  // Future<List<PropertyModel>> searchProperties(String location) async {
  //   final response = await dio.get(
  //     '/api/seller/properties/search',
  //     queryParameters: {"location": location},
  //   );

  //   if (response.data == null || response.data['results'] == null) {
  //     return [];
  //   }

  //   return (response.data['results'] as List)
  //       .map((e) => PropertyModel.fromJson(e))
  //       .toList();
  // }
  // Future<List<PropertyModel>> searchProperties(String location) async {
  //   print("SEARCH LOCATION: $location");

  //   final response = await dio.get(
  //     '/api/seller/properties/search',
  //     queryParameters: {"location": location},
  //   );

  //   print("DATA RESPONSE/////////////////////:${response.data}");

  //   if (response.data == null || response.data['results'] == null) {
  //     return [];
  //   }

  //   return (response.data['results'] as List)
  //       .map((e) => PropertyModel.fromJson(e))
  //       .toList();
  // }
  // Future<List<PropertyModel>> searchProperties(String location) async {
  //   try {
  //     print("SEARCH LOCATION: $location");

  //     final response = await dio.get(
  //       '/api/seller/properties/search',
  //       queryParameters: {"location": location},
  //     );

  //     print("DATA RESPONSE: ${response.data}");

  //     if (response.data == null || response.data['results'] == null) {
  //       return [];
  //     }

  //     return (response.data['results'] as List)
  //         .map((e) => PropertyModel.fromJson(e))
  //         .toList();
  //   } catch (e) {
  //     print("SEARCH API ERROR: $e");
  //     return [];
  //   }
  // }
  Future<List<PropertyModel>> searchProperties(String location) async {
    try {
      final token = await SharedHelper.getToken(); // get saved token

      final response = await dio.get(
        //'/api/seller/properties/search',
        "https://movin-app.vercel.app/api/seller/properties/search",

        queryParameters: {"location": location},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      print("DATA RESPONSE: ${response.data}");

      if (response.data == null || response.data['results'] == null) {
        return [];
      }

      return (response.data['results'] as List)
          .map((e) => PropertyModel.fromJson(e))
          .toList();
    } catch (e) {
      print("SEARCH API ERROR: $e");
      return [];
    }
  }

  Future<List<PropertyModel>> getRecentProperties() async {
    final response = await dio.get("/api/seller/properties/recent-properties");

    final List data = response.data["recentProperties"];

    return data.map((e) => PropertyModel.fromJson(e)).toList();
  }

  Future<List<PropertyModel>> getRecommendedProperties() async {
    final response = await dio.get('/api/recommend/all');

    if (response.data == null || response.data['recommendations'] == null) {
      return [];
    }

    return (response.data['recommendations'] as List)
        .map((e) => PropertyModel.fromJson(e))
        .toList();
  }
}
