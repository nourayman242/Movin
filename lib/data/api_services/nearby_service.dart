import 'package:dio/dio.dart';

class NearbyService {
  final Dio dio;

  NearbyService(this.dio);

  Future<List<dynamic>> getNearbyPlaces({
    required double lat,
    required double lng,
    required String type,
  }) async {
    final response = await dio.get(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
      queryParameters: {
        'location': '$lat,$lng',
        'radius': 3000,
        'type': type,
        'key': 'AIzaSyCfUhipRKNuYrW1ucfUPFmXwT7OYViZ9cQ',
      },
    );

    return response.data['results'];
  }
}