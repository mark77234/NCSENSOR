import 'package:flutter/material.dart';
import 'package:taesung1/screens/manage_screen.dart';

import '../screens/blt_test_screen.dart';
import '../screens/entry_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen.dart';

class AppRoutes {
  static const String entry = '/';
  static const String login = '/login';
  static const String main = '/main';
  static const String measure = '/measure';
  static const String history = '/history';
  static const String statistics = '/statistics';
  static const String profile = '/profile';
  static const String manage = '/profile/manage';
  static const String bleTest = '/bleTest';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      entry: (_) => EntryScreen(),
      login: (_) => LoginScreen(),
      main: (_) => MainScreen(),
      measure: (_) => MainScreen(selectedIndex: 0),
      history: (_) => MainScreen(selectedIndex: 1),
      statistics: (_) => MainScreen(selectedIndex: 2),
      profile: (_) => MainScreen(selectedIndex: 3),
      manage: (_) => ManageScreen(),
      bleTest: (_) => BltTestScreen(),
    };
  }
//에니메이션 같은 거 넣을려면 generateroute를 사용해야 함
}
