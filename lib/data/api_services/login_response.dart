
import 'package:movin/data/api_services/user_response.dart';

class LoginResponse {
  final String token;
  final String message;
   final UserResponse user;

  LoginResponse( {required this.token, required this.message,required this.user,});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(
        token: json["token"] ?? "",
        message: json["message"] ?? "",
        user: UserResponse.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
    "token": token,
    "message": message,
  };
}
