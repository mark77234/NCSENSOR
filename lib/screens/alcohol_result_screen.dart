import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taesung1/screens/measure_screen.dart';
import 'bottom_navigation_bar.dart';

class AlcoholResultScreen extends StatefulWidget {
  const AlcoholResultScreen({super.key});

  @override
  _AlcoholResultScreenState createState() => _AlcoholResultScreenState();
}

class _AlcoholResultScreenState extends State<AlcoholResultScreen> {
  // BottomNavigationBar의 선택된 인덱스를 저장할 변수
  int _selectedIndex = 0;

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

  // 아이템 탭 시 동작을 처리하는 메서드
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MeasureScreen()), // MeasureScreen으로 이동
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "음주 측정 결과",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3B82F6),
          ),
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
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}