import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taesung1/screens/main_screen.dart';
import '../constants/styles.dart';

class AlcoholResultScreen extends StatefulWidget {
  const AlcoholResultScreen({super.key});

  @override
  _AlcoholResultScreenState createState() => _AlcoholResultScreenState();
}

class _AlcoholResultScreenState extends State<AlcoholResultScreen> {

  // 혈중 알코올 농도 (랜덤 값)
  double _alcoholLevel = Random().nextDouble() * 0.10;

  // 면허 상태에 대한 텍스트
  String _licenseStatus = '';

  // 프로그래스 바의 색상
  Color _progressBarColor = Colors.green;

  @override
  void initState() {
    super.initState();
    // 면허 상태 결정
    if (_alcoholLevel <= 0.03) {
      _licenseStatus = '정상입니다';
      _progressBarColor = Colors.green;
    } else if (_alcoholLevel <= 0.08) {
      _licenseStatus = '면허정지 수준입니다';
      _progressBarColor = Colors.orange;
    } else {
      _licenseStatus = '면허취소 수준입니다';
      _progressBarColor = Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "음주 측정 결과",
          style: TextStyles.title,
        ),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: ColorStyles.primary,
            size:30.0,
          ), // 홈 아이콘
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()), // MainScreen으로 이동
                  (Route<dynamic> route) => false, // 모든 이전 페이지를 스택에서 제거
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '음주 측정이 완료되었습니다.',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            // 음주 측정 결과 표시
            Text(
              '측정 결과: ${_alcoholLevel.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // 프로그래스 바
            SizedBox(
              width: 300,
              child: LinearProgressIndicator(
                value: _alcoholLevel / 0.10,
                backgroundColor: Colors.grey[300],
                color: _progressBarColor,
                minHeight: 20,
              ),
            ),
            const SizedBox(height: 20),
            // 면허 상태 표시
            Text(
              _licenseStatus,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}