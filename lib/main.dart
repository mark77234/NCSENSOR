import 'package:flutter/material.dart';
import 'package:taesung1/constants/styles.dart';
import 'package:taesung1/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorStyles.primary, // 앱의 기본 색상 설정
        scaffoldBackgroundColor: ColorStyles.background, // 앱의 배경 색상 설정
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorStyles.background, // 앱 바의 색상 설정
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: ColorStyles.background, // 바텀 네비게이션 바의 색상 설정
          selectedItemColor: Color(0xFF2C46BD),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      home: const Splashscreen(), // SplashScreen 호출
    );
  }
}