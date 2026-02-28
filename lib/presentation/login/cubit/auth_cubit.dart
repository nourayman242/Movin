import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/domain/repositories/auth_repository.dart';
import 'package:movin/presentation/login/cubit/auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;

  AuthCubit(this.repo) : super(AuthInitial());

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());

    try {
      final token = await repo.loginWithGoogle();

      await SharedHelper.saveToken(token);

      emit(AuthSuccess(token));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}