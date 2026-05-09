import 'package:dio/dio.dart';
import 'package:movin/data/models/property_model.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';

const bool _apiSortSupported = false;

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

  FilteredPropertiesResponse withSortedProperties(String sortLabel) {
    final sorted = List<PropertyModel>.from(properties);

    switch (sortLabel) {
      case 'Price: Low to High':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Newest First':
        sorted.sort((a, b) {
          final aDate = a.createdAt ?? DateTime(2000);
          final bDate = b.createdAt ?? DateTime(2000);
          return bDate.compareTo(aDate);
        });
        break;
      case 'Most Popular':
        sorted.sort((a, b) => b.views.compareTo(a.views));
        break;
    }

    return FilteredPropertiesResponse(
      page: page,
      limit: limit,
      total: total,
      totalPages: totalPages,
      properties: sorted,
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
  }) async {
    final dio = getIt<Dio>();

 
    final Map<String, dynamic> baseParams = {};
    if (location != null && location.isNotEmpty) {
      baseParams['location'] = location;
    }
    if (type != null && type.isNotEmpty) {
      baseParams['type'] = type.toLowerCase();
    }
    if (bedrooms != null && bedrooms.isNotEmpty) {
      baseParams['bedrooms'] = bedrooms.replaceAll('+', '');
    }
    if (bathrooms != null && bathrooms.isNotEmpty) {
      baseParams['bathrooms'] = bathrooms.replaceAll('+', '');
    }
    if (pool != null) {
      baseParams['pool'] = pool.toString();
    }
    if (minPrice != null && minPrice > 0) {
      baseParams['minPrice'] = minPrice.toInt();
    }
    if (maxPrice != null && maxPrice < 10000000) {
      baseParams['maxPrice'] = maxPrice.toInt();
    }
    if (_apiSortSupported && sort != null && sort.isNotEmpty) {
      baseParams['sort'] = sort;
    }

    try {
    
      final firstResponse = await dio.get(
        _endpoint,
        queryParameters: {
          ...baseParams,
          'page': 1,
          'limit': 50, 
        },
      );

      var firstResult = FilteredPropertiesResponse.fromJson(
        firstResponse.data as Map<String, dynamic>,
      );

      final totalPages = firstResult.totalPages;
      final allProperties = List<PropertyModel>.from(firstResult.properties);

      
      if (totalPages > 1) {
        final remainingFutures = List.generate(
          totalPages - 1,
          (i) => dio.get(
            _endpoint,
            queryParameters: {
              ...baseParams,
              'page': i + 2,
              'limit': 50,
            },
          ),
        );

        final remainingResponses = await Future.wait(remainingFutures);
        for (final response in remainingResponses) {
          final pageResult = FilteredPropertiesResponse.fromJson(
            response.data as Map<String, dynamic>,
          );
          allProperties.addAll(pageResult.properties);
        }
      }

     
      var fullResult = FilteredPropertiesResponse(
        page: 1,
        limit: firstResult.limit,
        total: firstResult.total,
        totalPages: totalPages,
        properties: allProperties,
      );

     
      if (!_apiSortSupported && sort != null && sort.isNotEmpty) {
        fullResult = fullResult.withSortedProperties(_apiSortToUiLabel(sort));
      }

      return fullResult;
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
      case 'Price: Low to High':
        return 'price-asc';
      case 'Price: High to Low':
        return 'price-desc';
      case 'Newest First':
        return 'newest';
      case 'Most Popular':
        return 'popular';
      default:
        return null;
    }
  }

  static String _apiSortToUiLabel(String apiSort) {
    switch (apiSort) {
      case 'price-asc':
        return 'Price: Low to High';
      case 'price-desc':
        return 'Price: High to Low';
      case 'newest':
        return 'Newest First';
      case 'popular':
        return 'Most Popular';
      default:
        return '';
    }
  }
}