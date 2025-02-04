class UserProfile {
  final String role;
  final String name;
  final String email;
  final String phone;
  final String? imagePath;

  UserProfile({
    required this.role,
    required this.name,
    required this.phone,
    required this.email,
    this.imagePath,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      role: json['role'],
      name: json['name'],
      phone: json['phone_number'],
      email: json['email'],
      imagePath: json['image_path'] ?? '', // 이미지 경로가 없을 경우 빈 문자열 기본값
    );
  }

  UserProfile copyWith({
    String? role,
    String? name,
    String? phone,
    String? email,
    String? imagePath,
  }) {
    return UserProfile(
      role: role ?? this.role,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath, // 이미지 경로 복사
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
