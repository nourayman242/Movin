import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/otp_services.dart';
import 'package:movin/data/models/otp_dto.dart';
import 'package:movin/domain/entities/otp_entity.dart';
import 'package:movin/domain/repositories/otp_repository.dart';

@LazySingleton(as: OtpRepository)
class OtpRepositoryImpl implements OtpRepository {
  final OtpServices api;

  OtpRepositoryImpl(this.api);

  @override
  Future<void> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final entity = OtpEntity(email: email, otp: otp);
    final dto = OtpDto.fromEntity(entity);

    print("Verify OTP DTO: ${dto.toJson()}");

    try {
      await api.verifyOtp(dto);
      return;
    } on DioError catch (e) {
      final msg = e.response?.data?['message'] ?? e.message;
      throw Exception(msg);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
