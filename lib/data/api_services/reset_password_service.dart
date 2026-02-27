import 'package:dio/dio.dart';
import 'package:movin/data/api_services/reset_pass_response.dart';
import 'package:retrofit/retrofit.dart';
import '../models/reset_pass_dto.dart';


part 'reset_password_service.g.dart';

@RestApi()
abstract class ResetPasswordService {
  factory ResetPasswordService(Dio dio, {String baseUrl}) = _ResetPasswordService;

  @POST("/api/auth/reset-password")
  Future<ResetPassResponse> resetPassword(@Body() ResetPasswordDto dto); // ← not void
}