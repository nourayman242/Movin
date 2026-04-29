import '../api_services/user_response.dart';

class GoogleAuthResponse {
  final String accessToken;
  final String refreshToken;
  final UserResponse user;

  GoogleAuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory GoogleAuthResponse.fromJson(Map<String, dynamic> json) {
    return GoogleAuthResponse(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      user: UserResponse.fromJson(json['user'] ?? {}),
    );
  }
}