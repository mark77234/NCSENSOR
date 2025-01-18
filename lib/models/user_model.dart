// {
// "role": "NOMAL",
// "name": "이태성",
// "email": "tsei@ts-ei.com",
// "phone_number": "010-1234-5678"
// }

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

class UserPermission {
  final int id;
  final String name;
  final String permission;

  const UserPermission({
    required this.id,
    required this.name,
    required this.permission,
  });
}
