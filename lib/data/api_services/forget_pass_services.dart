import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'forget_pass_services.g.dart';

@RestApi()
abstract class ForgotPasswordService {
  factory ForgotPasswordService(
    Dio dio, {
    String baseUrl,
  }) = _ForgotPasswordService;

  @POST("/api/auth/forgot-password")
  Future<void> sendOtp(
    @Body() Map<String, dynamic> body,
  );

}
