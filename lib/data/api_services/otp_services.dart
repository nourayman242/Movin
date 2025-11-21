import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/otp_dto.dart';

part 'otp_services.g.dart';

@RestApi()
abstract class OtpServices {
  factory OtpServices(Dio dio, {String baseUrl}) = _OtpServices;

  @POST("/api/auth/verify-otp")
  Future<void> verifyOtp(@Body() OtpDto dto);
}
