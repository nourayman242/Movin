import 'package:movin/domain/entities/role_entity.dart';

class RoleDto {
  String role;
  RoleDto({required this.role});

  factory RoleDto.fromJson(Map<String, dynamic> json) {
    return RoleDto(
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
    };
  }

  RoleEntity toEntity() {
    return RoleEntity(role: role);
  }
  factory RoleDto.fromEntity(RoleEntity entity) {
    return RoleDto(role: entity.role);
  }
}
