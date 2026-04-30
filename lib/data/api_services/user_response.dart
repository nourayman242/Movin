
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  
  @JsonKey(fromJson: _phoneFromJson)
  final String phone;

  final bool? isAdmin;
  final bool? isSeller;
  final bool? isBuyer;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.isAdmin,
    this.isSeller,
    this.isBuyer,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  static String _phoneFromJson(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }
}
