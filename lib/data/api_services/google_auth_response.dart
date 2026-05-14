
import 'package:json_annotation/json_annotation.dart';
import 'user_response.dart';

part 'google_auth_response.g.dart';

@JsonSerializable()
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

  Map<String, dynamic> toJson() => _$GoogleAuthResponseToJson(this);
}