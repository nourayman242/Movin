import 'package:dio/dio.dart';
import 'package:movin/data/api_services/socket_service.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
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
    final statusCode = err.response?.statusCode;

    if ((statusCode == 401 || statusCode == 403) && !_isRefreshing) {
      _isRefreshing = true;
      print("🔄 Token expired → trying refresh token");

      try {
        final newToken = await _refreshToken();

        if (newToken != null) {
          print("✅ Token refreshed successfully");

          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';

          final response = await dio.fetch(options);
          _isRefreshing = false;
          return handler.resolve(response);
        }
      } catch (e) {
        print("❌ Refresh token failed → logging out: $e");
        await SharedHelper.clearAll();
      }

      _isRefreshing = false;
    }

    handler.next(err);
  }

Future<String?> _refreshToken() async {
  final refreshToken = await SharedHelper.getRefreshToken();
  if (refreshToken == null) return null;

  final plainDio = Dio(BaseOptions(
    baseUrl: 'https://movin-backend-production.up.railway.app',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  final response = await plainDio.post(
    "/api/auth/refresh-token",
    data: {"refreshToken": refreshToken},
  );

  print("🔁 Refresh response: ${response.data}");

  final newAccessToken = response.data["accessToken"] as String;
  
  final newRefreshToken = response.data["refreshToken"] as String?;
  if (newRefreshToken != null) {
    await SharedHelper.saveRefreshToken(newRefreshToken);
  }

  await SharedHelper.saveToken(newAccessToken);

try {
  final socketService = getIt<SocketService>();
  socketService.reconnect();
} catch (e) {
  print("Socket reconnect skipped: $e");
}
  return newAccessToken;
}
}