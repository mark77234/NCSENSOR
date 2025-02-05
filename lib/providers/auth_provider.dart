import 'package:NCSensor/services/api_service.dart';
import 'package:NCSensor/storage/secure_storage.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  AuthProvider();

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String username, String password) async {
    final response =
        await ApiService.user.login(username: username, password: password);

    final String accessToken = response['access_token'];
    final String refreshToken = response['refresh_token'];
    await SecureStorage.saveAccessToken(accessToken);
    await SecureStorage.saveRefreshToken(refreshToken);

    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
