import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/otp_services.dart';
import 'package:movin/domain/entities/otp_entity.dart';
import 'package:movin/domain/repositories/otp_repository.dart';
import '../../data/models/otp_dto.dart';

@LazySingleton(as: OtpRepository)
class OtpRepositoryImpl implements OtpRepository {
  final OtpServices api;

  OtpRepositoryImpl(this.api);

  @override
  Future<String> verifyOtp({required String email, required String otp}) async {
    final dto = OtpDto.fromEntity(OtpEntity(email: email, otp: otp));
    try {
      final response = await api.verifyOtp(dto);
      return response.message ?? "OTP verified successfully";
    } on DioException catch (e) {
      final msg = e.response?.data?['message'] ?? e.message;
      throw Exception(msg);
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}