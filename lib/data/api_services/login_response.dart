// import 'package:json_annotation/json_annotation.dart';
// import 'package:movin/data/api_services/user_response.dart';
// part 'login_response.g.dart';

// @JsonSerializable()
// class LoginResponse {
//   final String message;
//   final String token;
//   final UserResponse user;

//   LoginResponse({required this.message, required this.user,required this.token});

//   factory LoginResponse.fromJson(Map<String, dynamic> json) =>
//       _$LoginResponseFromJson(json);
// }

class LoginResponse {
  final String token;
  final String message;

  LoginResponse({required this.token, required this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(
        token: json["token"] ?? "",
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
    "token": token,
    "message": message,
  };
}
