import 'package:dio/dio.dart';
import 'package:movin/data/api_services/forget_pass_response.dart';
import 'package:retrofit/retrofit.dart';

part 'forget_pass_services.g.dart';

@RestApi()
abstract class ForgotPasswordService {
  factory ForgotPasswordService(Dio dio, {String baseUrl}) = _ForgotPasswordService;

  @POST("/api/auth/forgot-password")
  Future<ForgetPassResponse> sendOtp(@Body() Map<String, dynamic> body); // ← return ForgetPassResponse not void
}


