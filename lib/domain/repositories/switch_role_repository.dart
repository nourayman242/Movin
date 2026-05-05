
import '../../data/api_services/role_selection_response.dart';

abstract class SwitchRoleRepository {
  Future<ChooseRoleResponse> switchRole(String newRole);
}