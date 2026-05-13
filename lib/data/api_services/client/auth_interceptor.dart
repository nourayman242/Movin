import 'package:dio/dio.dart';
import 'package:movin/data/api_services/socket_service.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/data_injection/getIt/service_locator.dart';

import '../../data_source/local/token_cache.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token =
        TokenCache.accessToken ?? await SharedHelper.getToken();
    print("🔐 REQUEST → ${options.path}");
    print("🔐 TOKEN → $token");

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    print("🔐 FINAL TOKEN: $token");
    print("👤 ROLE FROM PREFS: ${await SharedHelper.getUserRole()}");
    print("📦 HEADERS → ${options.headers}");
    print("🧠 DIO BASE URL → ${options.baseUrl}");
    print("🧠 FULL URL → ${options.uri}");

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    print("STATUS CODE => $statusCode");
    print("ACCESS TOKEN => ${TokenCache.accessToken}");
    print("REFRESH TOKEN => ${TokenCache.refreshToken}");

    if ((statusCode == 401   || statusCode == 403)&& !_isRefreshing) {
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
        //TokenCache.clear();
        await SharedHelper.clearAll();
      }

      _isRefreshing = false;
    }

    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await SharedHelper.getRefreshToken();
    print("🔁 refresh token → $refreshToken");
    if (refreshToken == null || refreshToken.isEmpty) return null;

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

    TokenCache.accessToken = newAccessToken;
    TokenCache.refreshToken = newRefreshToken;
    await SharedHelper.saveToken(newAccessToken);

    if (newRefreshToken != null) {
      await SharedHelper.saveRefreshToken(newRefreshToken);
    }

    try {
      final socketService = getIt<SocketService>();
      socketService.reconnect();
    } catch (e) {
      print("Socket reconnect skipped: $e");
    }

    return newAccessToken;
  }
}