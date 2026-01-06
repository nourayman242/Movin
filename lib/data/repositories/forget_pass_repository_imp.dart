import '../../domain/repositories/forget_pass_repository.dart';
import '../api_services/forget_pass_services.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordService service;

  ForgotPasswordRepositoryImpl(this.service);

  @override
  Future<void> sendOtp({required String email}) async {
    await service.sendOtp({
      "email": email,
    });
  }
}
