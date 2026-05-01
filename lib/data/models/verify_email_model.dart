import '../api_services/user_response.dart';

class VerifyEmailResponse {
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserResponse user;

  VerifyEmailResponse({
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory VerifyEmailResponse.fromJson(Map<String, dynamic> json) {
    return VerifyEmailResponse(
      message: json['message'] ?? '',
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: UserResponse.fromJson(json['user'] ?? {}),
    );
  }
}