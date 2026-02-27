import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class GoogleAuthService {
  Future<Map<String, dynamic>> signInWithGoogle() async {
    final result = await FlutterWebAuth2.authenticate(
      url: "https://movin-app.vercel.app/api/auth/google",
      callbackUrlScheme: "movin",
     // options: const FlutterWebAuth2Options(preferEphemeral: true),
    );

    final uri = Uri.parse(result);

    // backend must send token in query params
    final token = uri.queryParameters['token'];

    if (token == null) {
      throw Exception("No token returned from Google login");
    }

    return {"token": token};
  }
}
