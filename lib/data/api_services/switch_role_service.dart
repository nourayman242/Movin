import 'package:dio/dio.dart';
import 'package:movin/data/api_services/role_selection_response.dart';
import 'package:retrofit/retrofit.dart';

part 'switch_role_service.g.dart';

@RestApi()
abstract class SwitchRoleService {
  factory SwitchRoleService(Dio dio, {String baseUrl}) = _SwitchRoleService;

  @PUT('/api/auth/switch-role')
  Future<ChooseRoleResponse> switchRole(
    @Body() Map<String, dynamic> body,
  );
}