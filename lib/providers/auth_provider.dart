import 'package:flutter/material.dart';
import 'package:taesung1/services/api_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String username, String password) async {
    final token =
        await ApiService.login(username: username, password: password);
    await ApiService().saveToken(token);

    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}
