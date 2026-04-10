import 'package:dio/dio.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';


class GoogleAuthService {
  // Future<Map<String, dynamic>> signInWithGoogle() async {
  //   try {
  //     final result = await FlutterWebAuth2.authenticate(
  //       url: "https://movin-backend.fly.dev/api/auth/google",
  //       callbackUrlScheme: "movin",
  //     );
  //     print("RESULT: $result");

  //     final uri = Uri.parse(result);

  //     final token = uri.queryParameters['token'];

  //     if (token == null || token.isEmpty) {
  //       throw Exception("Authentication failed: token missing");
  //     }
      
  //     return {"token": token};
  //   } catch (e) {
  //     throw Exception("Google login cancelled or failed");
  //   }
  // }
   final Dio dio = Dio(
    BaseOptions(baseUrl: "https://movin-backend.fly.dev"),
  );

  Future<Map<String, dynamic>> signInWithGoogle() async {
    final result = await FlutterWebAuth2.authenticate(
      url: "https://movin-backend.fly.dev/api/auth/google",
      callbackUrlScheme: "movin",
    );

    final uri = Uri.parse(result);

    final token = uri.queryParameters['token'];

    if (token == null || token.isEmpty) {
      throw Exception("Authentication failed");
    }

   
    final response = await dio.get(
      "/api/auth/google/callback",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    return {
      "token": token,
      "user": response.data['user'], 
    };
  }
}
