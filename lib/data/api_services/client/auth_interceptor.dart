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
import 'package:dio/dio.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SharedHelper.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Content-Type'] = 'application/json';

    handler.next(options);
  }
}

