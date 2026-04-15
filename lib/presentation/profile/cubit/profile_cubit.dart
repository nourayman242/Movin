import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movin/data/models/profile_model.dart';
import 'package:movin/domain/repositories/profile_repository.dart';

class ProfileState {
  final ProfileModel? profile;
  final bool isLoading;
  final bool isUpdating;
  final String? error;

  ProfileState({
    this.profile,
    this.isLoading = false,
    this.isUpdating = false,
    this.error,
  });

  ProfileState copyWith({
    ProfileModel? profile,
    bool? isLoading,
    bool? isUpdating,
    String? error,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? false,
      isUpdating: isUpdating ?? false,
      error: error,
    );
  }
}

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repo;

  ProfileCubit(this.repo) : super(ProfileState());

  Future<void> getProfile() async {
    emit(state.copyWith(isLoading: true));

    try {
      final profile = await repo.getProfile();

      emit(state.copyWith(
        profile: profile,
        isLoading: false,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> updateProfile({
    required String username,
    required String bio,
    required String location,
    required String phone
  }) async {
    emit(state.copyWith(isUpdating: true));

    try {
      final updatedProfile = await repo.updateProfile(
        username: username,
        bio: bio,
        location: location,
        phone:phone
      );

      emit(state.copyWith(
        profile: updatedProfile,
        isUpdating: false,
        error: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isUpdating: false,
        error: e.toString(),
      ));
    }
  }
}