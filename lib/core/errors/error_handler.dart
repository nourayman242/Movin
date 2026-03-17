import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorHandler {
  //handle the error , display the failure msg

  static Failure handle(dynamic error) {

    if (error is DioException) {

      switch (error.type) {

        case DioExceptionType.connectionTimeout:
          return Failure(message: "Connection timeout");

        case DioExceptionType.receiveTimeout:
          return Failure(message: "Receive timeout");

        case DioExceptionType.badResponse:

          final statusCode = error.response?.statusCode;

          if (statusCode == 401) {
            return Failure(message: "Unauthorized", code: 401);
          }

          if (statusCode == 404) {
            return Failure(message: "Not Found", code: 404);
          }

          if (statusCode == 500) {
            return Failure(message: "Server Error", code: 500);
          }
          final msg = error.response?.data['message'];
          return Failure(message: msg ?? "Unknown server error", code: statusCode);

        case DioExceptionType.connectionError:
          return Failure(message: "No internet connection");

        default:
          return Failure(message: "Unexpected error");
      }

    }

    return Failure(message: "Unknown error");
  }
}
