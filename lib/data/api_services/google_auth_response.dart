
import 'package:json_annotation/json_annotation.dart';
import 'user_response.dart';

part 'google_auth_response.g.dart';

@JsonSerializable()
class GoogleAuthResponse {
  final String token;
  final UserResponse user;

  GoogleAuthResponse({
    required this.token,
    required this.user,
  });

  factory GoogleAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleAuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleAuthResponseToJson(this);
}