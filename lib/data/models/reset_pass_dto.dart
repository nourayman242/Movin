import '../../domain/entities/reset_pass_entity.dart';

class ResetPasswordDto {
  final String email;
  final String newPassword;

  ResetPasswordDto({required this.email, required this.newPassword});

  factory ResetPasswordDto.fromEntity(ResetPasswordEntity entity) {
    return ResetPasswordDto(
      email: entity.email,
      newPassword: entity.newPassword,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newPassword': newPassword,
    };
  }
}
