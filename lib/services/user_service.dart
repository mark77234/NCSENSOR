import 'package:dio/dio.dart';

import '../models/data/user_model.dart';
import '../storage/secure_storage.dart';

class UserService {
  Dio _apiClient;

  // 싱글톤
  UserService._(this._apiClient);

  static UserService? _instance;

  factory UserService(Dio dio) {
    _instance ??= UserService._(dio);
    return _instance!;
  }

  Future<dynamic> login({
    required String username,
    required String password,
  }) async {
    final response = await _apiClient.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
      },
      options: Options(
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      ),
    );
    return response.data;  // Ensure this returns the parsed JSON map
  }

  Future<void> signup({
    required String username,
    required String password,
    required String name,
    required String email,
    required String phoneNumber,
  }) async {
    await _apiClient.post('/signup', data: {
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
    });
  }

  Future<UserProfile> getUserProfile() async {
    final token = await SecureStorage.getToken();
    if (token == null) {
      throw Exception('JWT 토큰이 없습니다. 다시 로그인 해주세요.');
    }

    final response = await _apiClient.get('/my',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Authorization 헤더에 JWT 포함
          },
        ));

    print(response.data); // 사용자 프로필 출력
    return UserProfile.fromJson(response.data);
  }

  Future<void> getUser() async {
    await _apiClient.get('/user');
  }
}
