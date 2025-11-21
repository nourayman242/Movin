import '../../domain/entities/otp_entity.dart';

class OtpDto {
  final String email;
  final String otp;

  OtpDto({required this.email, required this.otp});

  factory OtpDto.fromEntity(OtpEntity entity) {
    return OtpDto(email: entity.email, otp: entity.otp);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}
