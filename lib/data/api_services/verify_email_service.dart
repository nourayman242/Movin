import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/verify_email_model.dart';

part 'verify_email_service.g.dart';

@RestApi()
abstract class VerifyEmailService {
  factory VerifyEmailService(Dio dio, {String baseUrl}) = _VerifyEmailService;

  @POST('/api/auth/verify-email')
  Future<VerifyEmailResponse> verifyEmail(
      @Body() Map<String, dynamic> body,
      );
}