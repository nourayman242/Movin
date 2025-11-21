import 'package:movin/domain/entities/otp_entity.dart';

class OtpDto {
  final String email;
  final String otp;

  OtpDto({
    required this.email,
    required this.otp,
  });

  factory OtpDto.fromJson(Map<String, dynamic> json) {
    return OtpDto(
      email: json['email'],
      otp: json['otp'],
    );
  }

  OtpEntity toEntity() {
    return OtpEntity(
      email: email,
      otp: otp,
    );
  }

  factory OtpDto.fromEntity(OtpEntity entity) {
    return OtpDto(
      email: entity.email,
      otp: entity.otp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}
