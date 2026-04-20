import 'package:movin/data/api_services/profile_services.dart';
import 'package:movin/data/models/profile_model.dart';
import 'package:movin/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileService service;

  ProfileRepositoryImpl(this.service);

  @override
  Future<ProfileModel> getProfile() async {
    final data = await service.getProfile();
    return ProfileModel.fromJson(data);
  }

  @override
  Future<ProfileModel> updateProfile({
    required String username,
    required String bio,
    required String location,
    required String phone
  }) async {
    final data = await service.updateProfile(
      username: username,
      bio: bio,
      location: location,
      phone:phone,
    );

    return ProfileModel.fromJson(data);
  }
}