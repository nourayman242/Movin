// import 'package:dio/dio.dart';
// import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';


// class AuthInterceptor extends Interceptor {
//   @override
//   void onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     final token = await SharedHelper.getToken();

//     if (token != null && token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }

//     options.headers['Content-Type'] = 'application/json';

//     super.onRequest(options, handler);
//   }
// }


// import 'package:dio/dio.dart';
// import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

// class AuthInterceptor extends Interceptor {
//   @override
//   void onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {

//     final token = await SharedHelper.getToken();

//     if (token != null && token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }

//     // لا تضيفي Content-Type هنا

//     handler.next(options);
//   }
// }

//AKER WAHED=============
// import 'package:dio/dio.dart';
// import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
//
// class AuthInterceptor extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options,
//       RequestInterceptorHandler handler,
//       ) async {
//     final token = await SharedHelper.getToken();
//     print("AUTH TOKEN → $token");
//     if (token != null && token.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//
//     //options.headers['Content-Type'] = 'application/json';
//
//     handler.next(options);
//   }
// }
import 'package:dio/dio.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  // =========================
  // 1️⃣ BEFORE REQUEST
  // =========================
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // 🔹 get saved token from storage
    final token = await SharedHelper.getToken();

    print("🔐 AUTH TOKEN → $token");

    // 🔹 if token exists → attach it to headers
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 🔹 continue request
    handler.next(options);
  }

  // =========================
  // 2️⃣ HANDLE ERRORS (IMPORTANT 🔥)
  // =========================
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // ❗ check if error is Unauthorized (token expired)
    if (err.response?.statusCode == 401) {
      print("⚠️ Token expired → trying refresh token");

      try {
        // 🔹 try to refresh token
        final newToken = await _refreshToken();

        if (newToken != null) {
          print("✅ Token refreshed successfully");

          // 🔹 retry original request with new token
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';

          final response = await dio.fetch(options);

          return handler.resolve(response);
        }
      } catch (e) {
        print("❌ Refresh token failed → logout user");

        await SharedHelper.clearAll();
      }
    }

    // 🔹 if not 401 → continue normal error
    handler.next(err);
  }

  // =========================
  // 3️⃣ REFRESH TOKEN API CALL
  // =========================
  Future<String?> _refreshToken() async {
    final refreshToken = await SharedHelper.getRefreshToken();

    if (refreshToken == null) return null;

    final response = await dio.post(
      "/api/auth/refresh-token",
      data: {
        "refreshToken": refreshToken,
      },
    );

    // 🔹 extract new tokens
    final data = response.data["accessToken"];

    final newAccessToken = data["accessToken"];
    final newRefreshToken = data["refreshToken"];

    // 🔹 save new tokens
    await SharedHelper.saveToken(newAccessToken);
    await SharedHelper.saveRefreshToken(newRefreshToken);

    return newAccessToken;
  }
}
