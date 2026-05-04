import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
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

  // factory UserResponse.fromJson(Map<String, dynamic> json) =>
  //     _$UserResponseFromJson(json);
  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(

      id: (json['id'] ?? json['_id'] ?? '').toString(),
      name: (json['name'] ?? json['username'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      phone: (json['phone'] ?? '').toString(),

      isAdmin: json['isAdmin'],
      isSeller: json['isSeller'],
      isBuyer: json['isBuyer'],
    );
  }

  //Map<String, dynamic> toJson() => _$UserResponseToJson(this);
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isAdmin': isAdmin,
      'isSeller': isSeller,
      'isBuyer': isBuyer,
    };
  }

  static String _phoneFromJson(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }
}
