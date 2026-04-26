

import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: '_id')
  final String id;

  final String username;
  final String email;

  @JsonKey(fromJson: _phoneFromJson)
  final int phone;

  final bool isSeller;
  final bool isBuyer;
  final bool isAdmin;

  UserResponse({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.isSeller,
    required this.isBuyer,
    required this.isAdmin,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  static int _phoneFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }
}