import 'package:NCSensor/screens/login/login_screen.dart';
import 'package:NCSensor/storage/base/preferences_storage.dart';
import 'package:NCSensor/storage/data/meta_storage.dart';
import 'package:flutter/material.dart';

import 'error_screen.dart';
import 'splash_screen.dart';

class EntryScreen extends StatefulWidget {
  EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  bool _isInitialized = false;

  Future<void> _initializeApp() async {
    if (_isInitialized) return;
    await PreferencesStorage.init();
    await UiStorage.init();
    _isInitialized = true;
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
