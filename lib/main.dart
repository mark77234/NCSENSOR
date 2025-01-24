import 'package:NCSensor/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/providers/auth_provider.dart';
import 'package:NCSensor/routes/app_routes.dart';

void main() {
  final apiService = ApiService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(apiService)),
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
        primaryColor: ColorStyles.lightgrey,
        highlightColor: ColorStyles.lightgrey,
        focusColor: ColorStyles.lightgrey,
        scaffoldBackgroundColor: ColorStyles.background,
        // 앱의 배경 색상 설정
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorStyles.background, // 앱 바의 색상 설정
          centerTitle: true, // 앱 바의 타이틀을 가운데 정렬
          titleTextStyle: TextStyles.title,
        ),
        canvasColor: Colors.white,
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white, // 다이얼로그의 색상 설정
          surfaceTintColor: Colors.white, // 다이얼로그의 표면 색상 설정
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
