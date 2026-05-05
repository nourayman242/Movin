import '../../data/api_services/role_selection_response.dart';

abstract class RoleRepository {
  //Future<void> chooseRole(String role);
  Future<ChooseRoleResponse> chooseRole(String role);
}
