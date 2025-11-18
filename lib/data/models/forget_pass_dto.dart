import 'package:movin/domain/entities/forget_pass_entity.dart';

class ForgetPassDto {
  final String email;

  ForgetPassDto({
    required this.email,
  });
  factory ForgetPassDto.fromJson(Map<String, dynamic> json) {
    return ForgetPassDto(
      email: json['email'],
    );
  }
  ForgetPasswordEntity toEntity() {
    return ForgetPasswordEntity(
      email: email,
    );
  }
  factory ForgetPassDto.fromEntity(ForgetPasswordEntity entity) {
    return ForgetPassDto(
      email: entity.email,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
