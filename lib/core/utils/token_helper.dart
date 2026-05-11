import 'package:jwt_decoder/jwt_decoder.dart';

class TokenHelper {

  static String? getUserId(String token) {
    try {
      final decodedToken = JwtDecoder.decode(token);

      return decodedToken["_id"];
    } catch (e) {
      return null;
    }
  }

  static bool isBuyer(String token) {
    try {
      final decodedToken = JwtDecoder.decode(token);

      return decodedToken["isBuyer"] ?? false;
    } catch (e) {
      return false;
    }
  }

  static bool isSeller(String token) {
    try {
      final decodedToken = JwtDecoder.decode(token);

      return decodedToken["isSeller"] ?? false;
    } catch (e) {
      return false;
    }
  }
}