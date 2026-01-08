import 'package:movin/domain/entities/register_entity.dart';

class RegisterDto {
  final String username;
  final String email;
  final String password;
  final String phone;

  RegisterDto({
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
  });

  factory RegisterDto.fromJson(Map<String, dynamic> json) {
  return RegisterDto(
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    password: '',
    phone: json['phone']?.toString() ?? '',
  );
}


  RegisterEntity toEntity() {
    return RegisterEntity(
      username: username,
      email: email,
      phone: phone,
      password: password,
    );
  }

  factory RegisterDto.fromEntity(RegisterEntity entity) {
    return RegisterDto(
      username: entity.username,
      email: entity.email,
      password: entity.password,
      phone: entity.phone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }
}
