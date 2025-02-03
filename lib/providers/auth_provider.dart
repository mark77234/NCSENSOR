import 'package:flutter/material.dart';
import 'package:NCSensor/services/api_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  final ApiService _apiService;

  AuthProvider(this._apiService);

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String username, String password) async {
    final token =
        await _apiService.login(username: username, password: password);
    await _apiService.saveToken(token);

    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
