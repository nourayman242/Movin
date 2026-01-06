
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: 'id')
  final String id;
  final String name;
  final String email;
  
  @JsonKey(fromJson: _phoneFromJson)
  final String phone;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  static String _phoneFromJson(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }
}
