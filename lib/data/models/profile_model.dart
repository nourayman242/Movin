
class ProfileModel {
  final String name;
  final String bio;
  final String email;
  final String phone;
  final String location;
  final bool isSeller;
  final bool isBuyer;

  final Map<String, dynamic> ?stats;


  ProfileModel({
    required this.name,
    required this.bio,
    required this.email,
    required this.phone,
    required this.location,
     required this.isSeller,
    required this.isBuyer,
    required this.stats,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final user = json["user"];
    final stats = json["stats"] ?? {};

    return ProfileModel(
      name: user["username"] ?? "",
      bio: user["bio"] ?? "",
      email: user["email"] ?? "",
      phone: user["phone"].toString(),
      location: user["location"] ?? "",
      isSeller: user["isSeller"] ?? false,
      isBuyer: user["isBuyer"] ?? false,
      stats: stats,
    );
  }

  // ProfileModel copyWith({
  //   String? name,
  //   String? bio,
  //   String? email,
  //   String? phone,
  //   String? location,
  // }) {
  //   return ProfileModel(
  //     name: name ?? this.name,
  //     bio: bio ?? this.bio,
  //     email: email ?? this.email,
  //     phone: phone ?? this.phone,
  //     location: location ?? this.location,
  //   );
  // }
  ProfileModel copyWith({
  String? name,
  String? bio,
  String? email,
  String? phone,
  String? location,
  bool? isSeller,
  bool? isBuyer,
  Map<String, dynamic>? stats,
}) {
  return ProfileModel(
    name: name ?? this.name,
    bio: bio ?? this.bio,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    location: location ?? this.location,
    isSeller: isSeller ?? this.isSeller,
    isBuyer: isBuyer ?? this.isBuyer,
    stats: stats ?? this.stats,
  );
}
}
