import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/user_response.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/domain/repositories/auth_repository.dart';
import 'package:movin/presentation/login/cubit/auth_state.dart';

import '../../../data_injection/getIt/service_locator.dart';
import '../../../domain/entities/login_entity.dart';
import '../../../domain/repositories/login_repositories.dart';
import '../../../domain/repositories/profile_repository.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepo;
  final LoginRepository repo;

  AuthCubit(this.authRepo , this.repo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final response = await repo.loginUser(
        LoginEntity(email: email, password: password),
      );

      await _saveUserData(
        response.accessToken,
        response.refreshToken,
        response.user,
      );
      emit(AuthSuccess(response.accessToken, response.user));

    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    emit(AuthLoading());

    try {
      final result = await authRepo.loginWithGoogle();

      final accessToken = result['accessToken'] as String;
      final refreshToken = result['refreshToken'] as String;
      await SharedHelper.saveToken(accessToken);
      await SharedHelper.saveRefreshToken(refreshToken);
      await SharedHelper.setLoggedIn(true);
//gded
      final profileRepo = getIt<ProfileRepository>();
      final profile = await profileRepo.getProfile();
//adeeeeeem
      // final userJson = result['user'];
      // UserResponse? user;
      // if (userJson != null) {
      //   user = UserResponse.fromJson(userJson);
      // }
      // await _saveUserData(accessToken, refreshToken, user);
      ///////////////
      emit(AuthGoogleSuccess(accessToken,profile));
         // user     //-> adem
      //));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  Future<void> _saveUserData( String accessToken,
      String refreshToken,UserResponse? user) async {
    await SharedHelper.saveToken(accessToken);
    await SharedHelper.saveRefreshToken(refreshToken);
    if (user != null) {
      await SharedHelper.saveUser(user);
      await SharedHelper.saveUserId(user.id);
    }
    await SharedHelper.setLoggedIn(true);
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await authRepo.logout();
      await SharedHelper.clearAll();

      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}