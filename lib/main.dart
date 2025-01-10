import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taesung1/constants/styles.dart';
import 'package:taesung1/providers/auth_provider.dart';
import 'package:taesung1/routes/app_routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.entry,
      routes: AppRoutes.getRoutes(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorStyles.primary, // 앱의 기본 색상 설정
        scaffoldBackgroundColor: ColorStyles.background, // 앱의 배경 색상 설정
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorStyles.background, // 앱 바의 색상 설정
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // 바텀 네비게이션 바의 색상 설정
          selectedItemColor: ColorStyles.primary, // 선택된 아이템의 색상 설정
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
