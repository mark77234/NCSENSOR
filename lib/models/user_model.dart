class UserProfile {
  String name;
  String phone;
  String email;
  String? imagePath;

  UserProfile({
    required this.name,
    required this.phone,
    required this.email,
    this.imagePath,
  });

  UserProfile copyWith({
    String? name,
    String? phone,
    String? email,
    String? imagePath,
  }) {
    return UserProfile(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
