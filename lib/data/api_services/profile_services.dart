import 'package:dio/dio.dart';

class ProfileService {
  final Dio dio;

  ProfileService(this.dio);

  Future<Map<String, dynamic>> getProfile() async {
    final response = await dio.get("/api/users/profile");
    return response.data;
  }

  Future<Map<String, dynamic>> updateProfile({
    required String username,
    required String bio,
    required String location,
    required String phone
  }) async {
    final response = await dio.put(
      "/api/users/profile",
      data: {
        "username": username,
        "bio": bio,
        "location": location,
        "phone":phone,
      },
    );
    return response.data;
  }
}