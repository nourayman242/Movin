import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/data/api_services/user_response.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/domain/repositories/auth_repository.dart';
import 'package:movin/presentation/login/cubit/auth_state.dart';


class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repo;

  AuthCubit(this.repo) : super(AuthInitial());

  // Future<void> loginWithGoogle() async {
  //   emit(AuthLoading());

  //   try {
  //     final token = await repo.loginWithGoogle();

  //     await SharedHelper.saveToken(token);

  //     emit(AuthSuccess(token));
  //   } catch (e) {
  //     emit(AuthError(e.toString()));
  //   }
  // }
  Future<void> loginWithGoogle() async {
  emit(AuthLoading());

  try {
    final result = await repo.loginWithGoogle();

    final token = result['token'];
    final user = UserResponse.fromJson(result['user']);

    await SharedHelper.saveToken(token);
    await SharedHelper.saveUserId(user.id); // ✅ هنا الحل

    emit(AuthSuccess(token, user));
  } catch (e) {
    emit(AuthError(e.toString()));
  }
}
}