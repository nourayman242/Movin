import 'package:dio/dio.dart';
import 'package:movin/data/models/property_model.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';

class FilteredPropertiesResponse {
  final int page;
  final int limit;
  final int total;
  final int totalPages;
  final List<PropertyModel> properties;

  FilteredPropertiesResponse({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.properties,
  });

  factory FilteredPropertiesResponse.fromJson(Map<String, dynamic> json) {
    return FilteredPropertiesResponse(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 1,
      properties: (json['properties'] as List<dynamic>? ?? [])
          .map((p) => PropertyModel.fromJson(p as Map<String, dynamic>))
          .toList(),
    );
  }
}

class FilterService {
  
  static const String _endpoint = '/api/seller/properties/filter';

  static Future<FilteredPropertiesResponse> fetchFilteredProperties({
    String? location,       
    String? type,
    String? bedrooms,
    String? bathrooms,
    bool? pool,
    double? minPrice,
    double? maxPrice,
    String? sort,
    int page = 1,
  }) async {
    final dio = getIt<Dio>();
    final Map<String, dynamic> queryParams = {};

    
    if (location != null && location.isNotEmpty) {
      queryParams['location'] = location.toLowerCase();
    }
    if (type != null && type.isNotEmpty) {
      queryParams['type'] = type.toLowerCase();
    }
    if (bedrooms != null && bedrooms.isNotEmpty) {
      queryParams['bedrooms'] = bedrooms.replaceAll('+', '');
    }
    if (bathrooms != null && bathrooms.isNotEmpty) {
      queryParams['bathrooms'] = bathrooms.replaceAll('+', '');
    }
    if (pool != null) {
      queryParams['pool'] = pool.toString();
    }
    if (minPrice != null && minPrice > 0) {
      queryParams['minPrice'] = minPrice.toInt();
    }
    if (maxPrice != null && maxPrice < 100000000) {
      queryParams['maxPrice'] = maxPrice.toInt();
    }
    if (sort != null && sort.isNotEmpty) {
      queryParams['sort'] = sort;
    }
    queryParams['page'] = page;

    try {
      final response = await dio.get(
        _endpoint,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return FilteredPropertiesResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw Exception(
            'Failed to load properties. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final message = e.response?.data?['message'] ?? e.message;
      throw Exception('Request failed [$status]: $message');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  static String? mapSortToApi(String? uiSort) {
    switch (uiSort) {
      case 'Newest':
        return 'newest';
      case 'Price: Low to High':
        return 'price-asc';
      case 'Price: High to Low':
        return 'price-desc';
      default:
        return null;
    }
  }
}