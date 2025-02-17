import 'package:flutter/material.dart';

import '../screens/common//entry_screen.dart';
import '../screens/common/main_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/manage/manage_screen.dart';

class AppRoutes {
  static const String entry = '/';
  static const String login = '/auth';
  static const String main = '/main';
  static const String measure = '/measure';
  static const String history = '/history';
  static const String statistics = '/statistics';
  static const String profile = '/profile';
  static const String manage = '/profile/manage';

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
    };
  }
//에니메이션 같은 거 넣을려면 generateroute를 사용해야 함
}
