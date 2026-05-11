import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movin/data/api_services/user_response.dart';
import 'package:movin/data/data_source/local/shard_prefrence/shared_helper.dart';
import 'package:movin/domain/repositories/auth_repository.dart';
import '../../../core/utils/token_helper.dart';
import '../../../data/data_source/local/token_cache.dart';
import '../../../data_injection/getIt/service_locator.dart';
import '../../../domain/entities/login_entity.dart';
import '../../../domain/repositories/login_repositories.dart';
import '../../../domain/repositories/profile_repository.dart';
import 'auth_state.dart';

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

      TokenCache.accessToken = accessToken;
      TokenCache.refreshToken = refreshToken;

      await SharedHelper.saveToken(accessToken);
      //
      print("TOKEN SAVED → ${await SharedHelper.getToken()}");
      //
      await SharedHelper.saveRefreshToken(refreshToken);
      final userId = TokenHelper.getUserId(accessToken);
      debugPrint("🔥 USER ID => $userId");

      if (userId != null) {
        await SharedHelper.saveUserId(userId);
      }

      final isBuyer = TokenHelper.isBuyer(accessToken);
      final isSeller = TokenHelper.isSeller(accessToken);
      debugPrint("🔥 isBuyer => $isBuyer");
      debugPrint("🔥 isSeller => $isSeller");

      await SharedHelper.setLoggedIn(true);

      if (isBuyer || isSeller) {

        final profileRepo = getIt<ProfileRepository>();

        final profile = await profileRepo.getProfile();

        // save role locally
        if (isBuyer) {
          await SharedHelper.setUserRole('buyer');
        } else {
          await SharedHelper.setUserRole('seller');
        }

        emit(
          AuthGoogleSuccess(
            accessToken,
            profile,
          ),
        );

        return;
      }

      emit(
        AuthGoogleSuccess(
          accessToken,
          null,
        ),
      );

    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _saveUserData( String accessToken,
      String refreshToken,UserResponse? user) async {

    await SharedHelper.saveToken(accessToken);
    //
    print("TOKEN SAVED → ${await SharedHelper.getToken()}");
    //
    await SharedHelper.saveRefreshToken(refreshToken);

    if (user != null) {
      await SharedHelper.saveUser(user);
      await SharedHelper.saveUserId(user.id);
    }

    await SharedHelper.setLoggedIn(true);
    print("✅ Tokens saved successfully");
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await authRepo.logout();
      TokenCache.clear();
      await SharedHelper.clearAll();

      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}