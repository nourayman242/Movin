import 'package:dio/dio.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:injectable/injectable.dart';

import '../models/google_auth_response_model.dart';

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

    print("🔥 accessToken → $accessToken");
    print("🔥 refreshToken → $refreshToken");

    if (accessToken == null || refreshToken==null) {
      throw Exception("Google login failed - missing tokens");
    }

   
    // final response = await dio.get(
    //   "/api/auth/google/callback",
    //   options: Options(
    //     headers: {
    //       "Authorization": "Bearer $token",
    //     },
    //   ),
    // );
    // final data = response.data;
    //
    // return {
    //   "accessToken": data["accessToken"] ?? "",
    //   "refreshToken": data["refreshToken"] ?? "",
    //   "user": data["user"],
    // };
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      //"user": null,
    };
  }
}
