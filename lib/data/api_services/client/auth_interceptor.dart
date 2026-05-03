
// import 'package:dio/dio.dart';
// import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

// class AuthInterceptor extends Interceptor {
//   final Dio dio;

//   AuthInterceptor(this.dio);

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler,
//       ) async {
//     final token = await SharedHelper.getToken();
//     print("🔐 REQUEST → ${options.path}");
//     print("🔐 TOKEN → $token");

//     if (token != null && token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     handler.next(options);
//   }


//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {

//     if (err.response?.statusCode == 401 ||err.response?.statusCode == 403) {
//       print("Token expired → trying refresh token");

//       try {
//         final newToken = await _refreshToken();

//         if (newToken != null) {
//           print("Token refreshed successfully");

//           final options = err.requestOptions;
//           options.headers['Authorization'] = 'Bearer $newToken';

//           final response = await dio.fetch(options);

//           return handler.resolve(response);
//         }
//       } catch (e) {
//         print("Refresh token failed → logout user");

//         await SharedHelper.clearAll();
//       }
//     }

//     handler.next(err);
//   }

//   Future<String?> _refreshToken() async {
//     final refreshToken = await SharedHelper.getRefreshToken();

//     if (refreshToken == null) return null;

//     final response = await dio.post(
//       "/api/auth/refresh-token",
//       data: {
//         "refreshToken": refreshToken,
//       },
//     );

//     final data = response.data["accessToken"];

//     final newAccessToken = data["accessToken"];
//     final newRefreshToken = data["refreshToken"];

//     await SharedHelper.saveToken(newAccessToken);
//     await SharedHelper.saveRefreshToken(newRefreshToken);

//     return newAccessToken;
//   }
// }
import 'package:dio/dio.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  bool _isRefreshing = false;

  AuthInterceptor(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip adding auth header for the refresh endpoint
    if (options.path.contains('/api/auth/refresh-token')) {
      return handler.next(options);
    }

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
    final path = err.requestOptions.path;

    // Never retry the refresh endpoint — breaks the infinite loop
    if (path.contains('/api/auth/refresh-token')) {
      return handler.next(err);
    }

    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      if (_isRefreshing) {
        return handler.next(err);
      }

      _isRefreshing = true;
      print("Token expired → trying refresh token");

      try {
        final newToken = await _refreshToken();

        if (newToken != null) {
          print("Token refreshed successfully");

          // Use a plain Dio instance to retry the original request
          // so it doesn't re-trigger this interceptor
          final plainDio = Dio(dio.options);

          final response = await plainDio.request(
            err.requestOptions.path,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
            options: Options(
              method: err.requestOptions.method,
              headers: {
                ...err.requestOptions.headers,
                'Authorization': 'Bearer $newToken',
              },
            ),
          );

          _isRefreshing = false;
          return handler.resolve(response);
        }
      } catch (e) {
        print("Refresh token failed → logout user");
        _isRefreshing = false;
        await SharedHelper.clearAll();
      }
    }

    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await SharedHelper.getRefreshToken();

    if (refreshToken == null) return null;

    // Plain Dio — no interceptors, no auth header added
    final plainDio = Dio(dio.options);

    final response = await plainDio.post(
      "/api/auth/refresh-token",
      data: {"refreshToken": refreshToken},
      options: Options(
        headers: {'Authorization': null},
      ),
    );

    final data = response.data["accessToken"];
    final newAccessToken = data["accessToken"];
    final newRefreshToken = data["refreshToken"];

    await SharedHelper.saveToken(newAccessToken);
    await SharedHelper.saveRefreshToken(newRefreshToken);

    return newAccessToken;
  }
}