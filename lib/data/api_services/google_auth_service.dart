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
    print("🔥 GOOGLE RESULT → $result");
    final uri = Uri.parse(result);

    final accessToken = uri.queryParameters['accessToken'];
    final refreshToken = uri.queryParameters['refreshToken'];
    final userId = uri.queryParameters['userId'];

    print("🔥 accessToken → $accessToken");
    print("🔥 refreshToken → $refreshToken");

    if (accessToken == null || refreshToken==null || userId == null) {
      throw Exception("Google login failed - missing tokens");
    }

    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "userId": userId,
      //"user": null,
    };
  }
}