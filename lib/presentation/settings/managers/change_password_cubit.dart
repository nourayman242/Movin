import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/domain/entities/change_password_entity.dart';
import 'package:movin/domain/repositories/change_password_repository.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordRepository repository;

  ChangePasswordCubit(this.repository) : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());
    try {
      final entity = ChangePasswordEntity(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      final message = await repository.changePassword(entity);
      emit(ChangePasswordSuccess(message: message));
    } catch (e) {
      emit(ChangePasswordFailure(e.toString()));
    }
  }
}