import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'favorite_api_service.g.dart';

@RestApi()
abstract class FavoriteApiService {
  factory FavoriteApiService(Dio dio) = _FavoriteApiService;

  // @POST('/api/buyer/favorites/{id}')
  // Future<Map<String, dynamic>> addFavorite(
  //   @Path('id') String propertyId,
  // );

  // @DELETE('/api/buyer/favorites/{id}')
  // Future<Map<String, dynamic>> removeFavorite(
  //   @Path('id') String propertyId,
  // );

  // @DELETE('/api/buyer/favorites/clear/all')
  // Future<Map<String, dynamic>> clearFavorites();

  // @GET('/api/buyer/favorites/get/all')
  // Future<Map<String, dynamic>> getFavorites();

   @POST('/api/buyer/favorites/{id}')
  Future<dynamic> addFavorite(@Path('id') String propertyId);

  @DELETE('/api/buyer/favorites/{id}')
  Future<dynamic> removeFavorite(@Path('id') String propertyId);

  @DELETE('/api/buyer/favorites/clear/all')
  Future<dynamic> clearFavorites();

  @GET('/api/buyer/favorites/get/all')
  Future<dynamic> getFavorites();
}