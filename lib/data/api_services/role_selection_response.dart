import 'package:movin/data/api_services/user_response.dart';

class ChooseRoleResponse {

  final String message;
  final String accessToken;
  final String refreshToken;
  final UserResponse safeUser;
  ChooseRoleResponse({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.safeUser,
  });

  factory ChooseRoleResponse.fromJson(Map<String, dynamic> json) {
    return ChooseRoleResponse(

      message: json['message'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',

      safeUser: UserResponse.fromJson(json['safeUser']),
    );
  }
}