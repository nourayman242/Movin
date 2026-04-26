
import 'dart:convert';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:injectable/injectable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:movin/data/api_services/google_auth_response.dart';
import 'package:movin/data/api_services/user_response.dart';

@lazySingleton
class GoogleAuthService {
  Future<GoogleAuthResponse> signInWithGoogle() async {
    try {
      final callbackUrl = await FlutterWebAuth2.authenticate(
        url: "https://movin-backend-production.up.railway.app/api/auth/google",
        callbackUrlScheme: "movin",
      );

      print("FULL CALLBACK URL => $callbackUrl");

      final uri = Uri.parse(callbackUrl);

      final token = uri.queryParameters['token'];

      if (token == null || token.isEmpty) {
        throw Exception("Google token missing");
      }

      UserResponse user;

      
      if (uri.queryParameters['user'] != null) {
        final userString = Uri.decodeComponent(uri.queryParameters['user']!);

        final userMap = jsonDecode(userString);

        user = UserResponse.fromJson(userMap);
      }

      
      else if (uri.queryParameters['email'] != null ||
          uri.queryParameters['username'] != null) {
        user = UserResponse(
          id: uri.queryParameters['_id'] ?? '',
          username: uri.queryParameters['username'] ?? '',
          email: uri.queryParameters['email'] ?? '',
          phone: int.tryParse(uri.queryParameters['phone'] ?? '0') ?? 0,
          isSeller: uri.queryParameters['isSeller'] == 'true',
          isBuyer: uri.queryParameters['isBuyer'] == 'true',
          isAdmin: uri.queryParameters['isAdmin'] == 'true',
        );
      }

      
      else {
        final decoded = JwtDecoder.decode(token);

        user = UserResponse(
          id: decoded['_id']?.toString() ?? '',
          username: '',
          email: '',
          phone: 0,
          isSeller: decoded['isSeller'] ?? false,
          isBuyer: decoded['isBuyer'] ?? false,
          isAdmin: decoded['isAdmin'] ?? false,
        );
      }

      return GoogleAuthResponse(token: token, user: user);
    } catch (e) {
      throw Exception("Google Sign-In Failed: $e");
    }
  }
}
