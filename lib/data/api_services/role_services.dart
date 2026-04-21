import 'package:dio/dio.dart';
import 'package:movin/data/models/role_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'role_services.g.dart';

@RestApi()
abstract class RoleServices {
  factory RoleServices(Dio dio, {String baseUrl}) = _RoleServices;

  @PUT('/api/auth/choose-role')
  Future<void> chooseRole(@Body() RoleDto dto);
}