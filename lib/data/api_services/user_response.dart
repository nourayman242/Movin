// // lib/data/models/user_response.dart
// import 'package:json_annotation/json_annotation.dart';

// part 'user_response.g.dart';

// @JsonSerializable()
// class UserResponse {
//   @JsonKey(name: '_id')
//   final String id;
//   final String name;
//   final String email;

//   UserResponse({
//     required this.id,
//     required this.name,
//     required this.email,
//   });

//   factory UserResponse.fromJson(Map<String, dynamic> json) =>
//       _$UserResponseFromJson(json);
// }
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: 'id')
  final String id;
  final String name;
  final String email;

  /// backend sends INT → convert safely
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
