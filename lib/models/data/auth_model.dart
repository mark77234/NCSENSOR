class AuthData {
  String accessToken;

  // String refreshToken;

  AuthData({
    required this.accessToken,
    // required this.refreshToken,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json['access_token'] as String,
      // refreshToken: json['refreshToken'] as String,
    );
  }
}
