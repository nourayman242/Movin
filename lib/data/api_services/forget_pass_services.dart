import 'package:dio/dio.dart';
import 'package:movin/data/api_services/forget_pass_response.dart';
import 'package:movin/data/models/forget_pass_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'forget_pass_services.g.dart';

@RestApi()
abstract class ForgetPassServices {
  factory ForgetPassServices(Dio dio, {String baseUrl}) = _ForgetPassServices;

  // POST /api/auth/forgot-password
  @POST('/api/auth/forgot-password')
  Future<ForgetPassResponse> sendForgetPassword(@Body() ForgetPassDto dto);
}
