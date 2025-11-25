// import 'package:movin/domain/entities/login_entity.dart';

// class LoginDto {
//   final String email;
//   final String password;

//   LoginDto({required this.email, required this.password});

//   factory LoginDto.fromJson(Map<String, dynamic> json) {
//     return LoginDto(email: json['email'], password: json['password']);
//   }

//   LoginEntity toEntity() {
//     return LoginEntity(email: email, password: password);
//   }

//   factory LoginDto.fromEntity(LoginEntity entity) {
//     return LoginDto(email: entity.email, password: entity.password);
//   }

//   Map<String, dynamic> toJson() {
//     return {'email': email, 'password': password};
//   }
// }
import 'package:movin/domain/entities/login_entity.dart';

class LoginDto {
  final String email;
  final String password;

  LoginDto({required this.email, required this.password});

  factory LoginDto.fromEntity(LoginEntity entity) =>
      LoginDto(email: entity.email, password: entity.password);

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
