import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/forget_pass_repository.dart';
import 'forget_pass_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepository repository;

  ForgotPasswordCubit(this.repository)
      : super(ForgotPasswordInitial());

  Future<void> sendOtp(String email) async {
    emit(ForgotPasswordLoading());
    try {
      await repository.sendOtp(email: email);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordFailure(e.toString()));
    }
  }
}
