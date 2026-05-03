
import 'package:dio/dio.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler,
      ) async {
    final token = await SharedHelper.getToken();
    print("🔐 REQUEST → ${options.path}");
    print("🔐 TOKEN → $token");

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }


  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    if (err.response?.statusCode == 401 ||err.response?.statusCode == 403) {
      print("Token expired → trying refresh token");

      try {
        final newToken = await _refreshToken();

        if (newToken != null) {
          print("Token refreshed successfully");

          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';

          final response = await dio.fetch(options);

          return handler.resolve(response);
        }
      } catch (e) {
        print("Refresh token failed → logout user");

        await SharedHelper.clearAll();
      }
    }

    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await SharedHelper.getRefreshToken();

    if (refreshToken == null) return null;

    final response = await dio.post(
      "/api/auth/refresh-token",
      data: {
        "refreshToken": refreshToken,
      },
    );

    final data = response.data["accessToken"];

    final newAccessToken = data["accessToken"];
    final newRefreshToken = data["refreshToken"];

    await SharedHelper.saveToken(newAccessToken);
    await SharedHelper.saveRefreshToken(newRefreshToken);

    return newAccessToken;
  }
}