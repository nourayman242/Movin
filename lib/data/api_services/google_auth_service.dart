import 'package:dio/dio.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GoogleAuthService {
  
   final Dio dio = Dio(
    BaseOptions(baseUrl: "https://movin-backend-production.up.railway.app"),
  );

  Future<Map<String, dynamic>> signInWithGoogle() async {
    final result = await FlutterWebAuth2.authenticate(
      url: "https://movin-backend-production.up.railway.app/api/auth/google",
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
