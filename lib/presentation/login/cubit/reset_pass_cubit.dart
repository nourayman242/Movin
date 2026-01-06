import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/reset_pass_repository.dart';
import '../../../domain/entities/reset_pass_entity.dart';
import 'reset_pass_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepository repository;

  ResetPasswordCubit(this.repository) : super(ResetPasswordInitial());

  Future<void> resetPassword({required String email, required String newPassword}) async {
    emit(ResetPasswordLoading());
    try {
      final entity = ResetPasswordEntity(email: email, newPassword: newPassword);
      await repository.resetPassword(entity);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
