// lib/data/models/user_response.dart
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: '_id')
  final String id;
  final String username;
  final String email;

  UserResponse({
    required this.id,
    required this.username,
    required this.email,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
