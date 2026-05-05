import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NewsService {
  final Dio dio;

  NewsService(@Named('newsDio') this.dio);

  Future<List<dynamic>> getRealEstateNews() async {
    final response = await dio.get(
      'https://api.currentsapi.services/v1/search',
      queryParameters: {
        'keywords':
            '"Egypt real estate" OR "Egypt property market" OR "New Cairo" OR "North Coast Egypt"',
        'language': 'en',
      },
      options: Options(
        headers: {
          'Authorization': 'yV0m0rAqRzmpGXSEs94uXPiwoWrzQl4r4dm1G_GXQm9broKO',
        },
      ),
    );

    print("NEWS RESPONSE = ${response.data}");

    return response.data['news'];
  }
}
