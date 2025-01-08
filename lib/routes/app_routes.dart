
import 'package:flutter/material.dart';
import 'package:alcohol_management/screens/alcohol_result_screen.dart';
import 'package:alcohol_management/screens/body_result_screen.dart';

import '../screens/alcohol_result_screen.dart';
import '../screens/body_result_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String main = '/main';
  static const String measure = '/measure';
  static const String history = '/history';
  static const String statistics = '/statistics';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case measure:
        return MaterialPageRoute(builder: (_) => MainScreen(selectedIndex: 0));
      case history:
        return MaterialPageRoute(builder: (_) => MainScreen(selectedIndex: 1));
      case statistics:
        return MaterialPageRoute(builder: (_) => MainScreen(selectedIndex: 2));
      case profile:
        return MaterialPageRoute(builder: (_) => MainScreen(selectedIndex: 3));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
        }
  }
}