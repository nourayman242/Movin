
import 'package:movin/data/api_services/user_response.dart';

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final String message;
   final UserResponse user;

  LoginResponse( { required this.accessToken,
  required this.refreshToken, required this.message,required this.user,});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(
        accessToken: json["accessToken"] ?? "",
        refreshToken: json["refreshToken"] ?? "",
        message: json["message"] ?? "",
        user: UserResponse.fromJson(json['user']),
      );


}
