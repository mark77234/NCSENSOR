import 'package:NCSensor/services/api_service.dart'; // API 서비스 임포트
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/ui_data_provider.dart';
import '../../storage/preferences_storage.dart';
import 'error_screen.dart';
import 'main_screen.dart';
import 'splash_screen.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  // entry_screen.dart
  Future<void> _initializeApp(BuildContext context) async {
    try {
      await PreferencesStorage.init();
      final uiData = await ApiService.getUiData();
      Provider.of<UiDataProvider>(context, listen: false).updateData(uiData);
      await Future.delayed(const Duration(seconds: 3));
    } catch (e) {
      print(">>>${e}");
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final initializationFuture = _initializeApp(context);
    return FutureBuilder(
      future: initializationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else if (snapshot.hasError) {
          return ErrorScreen(error: snapshot.error.toString());
        } else {
          return const MainScreen();
        }
      },
    );
  }
}
