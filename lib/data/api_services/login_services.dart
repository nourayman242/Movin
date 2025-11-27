// import 'package:dio/dio.dart';
// import 'package:movin/data/api_services/login_response.dart';
// import 'package:movin/data/models/login_dto.dart';
// import 'package:retrofit/error_logger.dart';
// import 'package:retrofit/http.dart';

// part 'login_services.g.dart';

// @RestApi()
// abstract class LoginServices {
//   factory LoginServices(Dio dio, {String baseUrl}) = _LoginServices;

  
//   @GET('/api/auth/login')
//   Future<LoginResponse> loginUser(@Body() LoginDto dto);
// }


import 'package:dio/dio.dart';
import 'package:movin/data/api_services/login_response.dart';
import 'package:movin/data/models/login_dto.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'login_services.g.dart';

@RestApi() 
abstract class LoginServices {
  factory LoginServices(Dio dio, {String baseUrl}) = _LoginServices;

  @POST('/api/auth/login')
  Future<LoginResponse> loginUser(@Body() LoginDto dto);
}
