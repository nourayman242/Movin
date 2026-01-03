class ProfileModel {
  String name;
  String bio;
  String email;
  String phone;
  String location;

  ProfileModel({
    required this.name,
    required this.bio,
    required this.email,
    required this.phone,
    required this.location,
  });

  ProfileModel copyWith({
    String? name,
    String? bio,
    String? email,
    String? phone,
    String? location,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
    );
  }
}
