import 'package:movin/data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel> getProfile();
  Future<ProfileModel> updateProfile({
    required String username,
    required String bio,
    required String location,
    required String phone
  });
}