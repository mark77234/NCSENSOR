import 'package:NCSensor/screens/auth/login_screen.dart';
import 'package:NCSensor/storage/base/preferences_storage.dart';
import 'package:NCSensor/storage/data/ui_storage.dart';
import 'package:flutter/material.dart';

import 'error_screen.dart';
import 'splash_screen.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  Future<void> _initializeApp() async {
    print(">>>_initializeApp");
    await PreferencesStorage.init();
    await UiStorage.init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else if (snapshot.hasError) {
          return ErrorScreen(error: snapshot.error);
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
