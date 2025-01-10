import 'package:flutter/material.dart';
import 'package:taesung1/screens/splash_screen.dart';

import 'login_screen.dart';
import 'main_screen.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  Future<bool> _checkLoginStatus() async {
    await Future.delayed(Duration(seconds: 3));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else if (snapshot.hasData && snapshot.data == true) {
          return MainScreen(); // 로그인된 상태 -> 메인 화면
        } else {
          return LoginScreen(); // 로그인 안된 상태 -> 로그인 화면
        }
      },
    );
  }
}