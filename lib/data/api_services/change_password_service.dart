import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../api_services/change_password_response.dart';
import '../models/change_password_dto.dart';

part 'change_password_service.g.dart';

@RestApi()
abstract class ChangePasswordService {
  // Uses the same authenticated Dio instance (with AuthInterceptor)
  // so the Bearer token is attached automatically.
  factory ChangePasswordService(Dio dio, {String baseUrl}) =
      _ChangePasswordService;

  @PATCH("/api/users/profile/change-password")
  Future<ChangePasswordResponse> changePassword(
    @Body() ChangePasswordDto dto,
  );
}