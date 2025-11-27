import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/domain/repositories/otp_repository.dart';
import 'package:movin/presentation/login/cubit/otp_state.dart';
//import 'package:movin/domain/usecases/send_otp_usecase.dart';


class OtpCubit extends Cubit<OtpState> {
  final OtpRepository repository;

  OtpCubit(this.repository) : super(OtpInitial());

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(OtpLoading());
    try {
      await repository.verifyOtp(email: email, otp: otp);
      emit(OtpSuccess());
    } catch (e) {
      emit(OtpFailure(e.toString()));
    }
  }
}

