import 'package:movin/data/api_services/register_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/register_dto.dart';

part 'register_services.g.dart';

@RestApi()
abstract class RegisterServices {
  factory RegisterServices(Dio dio, {String baseUrl}) = _RegisterServices;

  // POST /api/auth/register
  @POST('/api/auth/register')
  Future<RegisterResponse> registerUser(@Body() RegisterDto dto);
}
