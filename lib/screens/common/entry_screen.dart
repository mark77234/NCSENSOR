import 'package:flutter/material.dart';

import '../../storage/base/preferences_storage.dart';
import '../../storage/data/ui_storage.dart';
import 'error_screen.dart';
import 'main_screen.dart';
import 'splash_screen.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  Future<void> _initializeApp(BuildContext context) async {
    await PreferencesStorage.init();
    await UiStorage.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else if (snapshot.hasError) {
          String error = '${snapshot.error}\n앱을 다시 실행해주세요';
          return ErrorScreen(error: error);
        } else {
          return const MainScreen();
        }
      },
    );
  }
}
