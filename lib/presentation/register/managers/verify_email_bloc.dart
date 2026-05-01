
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'verify_email_event.dart';
import 'verify_email_state.dart';

import '../../../data/data_source/local/shard_prefrence/shared_helper.dart';
import '../../../domain/repositories/verify_email_repository.dart';

@injectable
class VerifyEmailBloc
    extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final VerifyEmailRepository repo;

  VerifyEmailBloc(this.repo) : super(VerifyEmailInitial()) {

    on<SubmitOtpEvent>(_onVerify);
  }

  Future<void> _onVerify(
      SubmitOtpEvent event, Emitter<VerifyEmailState> emit,) async {
    emit(VerifyEmailLoading());

    try {
      final cleanOtp = event.otp.trim();
      final res = await repo.verify(
        event.email,
        //event.otp,
        cleanOtp
      );
      final token = res.accessToken;
      final refresh = res.refreshToken;
      final user = res.user;

      if (token == null || refresh == null || user == null) {
        emit(VerifyEmailError("Invalid server response"));
        return;
      }

      await SharedHelper.saveToken(token);
      await SharedHelper.saveRefreshToken(refresh);
      await SharedHelper.saveUser(res.user);
      await SharedHelper.saveUserId(user.id);
      await SharedHelper.setLoggedIn(true);

      emit(VerifyEmailSuccess());

    } catch (e) {
      emit(VerifyEmailError(e.toString()));
    }
  }
}