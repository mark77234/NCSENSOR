import 'package:NCSensor/storage/data/auth_storage.dart';
import 'package:dio/dio.dart';

import '../models/data/auth_model.dart';
import '../models/data/user_model.dart';

/// 사용자 api 정의하는 클래스
class UserService {
  Dio _apiClient;
  Options _authedOption;

  // 싱글톤
  UserService._(this._apiClient, this._authedOption);

  static UserService? _instance;

  factory UserService(Dio dio, Options authedOption) {
    _instance ??= UserService._(dio, authedOption);
    return _instance!;
  }

  Future<AuthData> login({
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
    final authData = AuthData.fromJson(response.data);
    await AuthStorage.saveTokens(accessToken: authData.accessToken);
    return authData; // Ensure this returns the parsed JSON map
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
    final response = await _apiClient.get('/my', options: _authedOption);
    return UserProfile.fromJson(response.data);
  }

  Future<void> getUser() async {
    await _apiClient.get('/user', options: _authedOption);
  }
}
