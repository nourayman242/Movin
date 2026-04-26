import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/domain/repositories/otp_repository.dart';
import 'package:movin/presentation/login/cubit/otp_state.dart';


class OtpCubit extends Cubit<OtpState> {
  final OtpRepository repository;

  OtpCubit(this.repository) : super(OtpInitial());

  Future<void> verifyOtp({required String email, required String otp}) async {
  emit(OtpLoading());
  try {
    final message = await repository.verifyOtp(email: email, otp: otp);
    emit(OtpSuccess(message: message));  // ← pass actual backend message
  } catch (e) {
    emit(OtpFailure(e.toString()));
  }
}
}

