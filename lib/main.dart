import 'package:flutter/material.dart';
import 'Splashscreen.dart'; // SplashScreen 파일 import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Splashscreen(), // SplashScreen 호출
    );
  }
}