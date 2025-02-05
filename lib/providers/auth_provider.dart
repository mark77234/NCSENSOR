import 'package:NCSensor/services/api_service.dart';
import 'package:NCSensor/storage/base/secure_storage.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  AuthProvider();

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String username, String password) async {
    final token =
        await ApiService.user.login(username: username, password: password);
    await SecureStorage.saveToken(token);

    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
