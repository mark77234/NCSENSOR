import 'package:NCSensor/screens/splash/splash_screen.dart';
import 'package:NCSensor/services/api_service.dart'; // API 서비스 임포트
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/ui_data_provider.dart';
import 'main_screen.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  Future<void> _initializeApp(BuildContext context) async {
    final uiData = await ApiService.getUiData();
    Provider.of<UiDataProvider>(context, listen: false).updateData(uiData);
    await Future.delayed(const Duration(seconds: 3)); // 최소 로딩 시간
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeApp(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const MainScreen();
        }
      },
    );
  }
}
