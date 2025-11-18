import 'package:movin/domain/entities/register_entity.dart';

abstract class RegisterRepository {
  Future<void> registerUser(RegisterEntity user);
}
