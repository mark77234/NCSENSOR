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

  // 단계 메시지 및 색상
  String _resultMessage = '';
  String _advice = '';
  Color _progressBarColor = Colors.green;

  @override
  void initState() {
    super.initState();
    _setAlcoholStage();
  }

  // 알코올 농도에 따른 상태 및 색상 설정
  void _setAlcoholStage() {
    if (_alcoholLevel <= 0.03) {
      _resultMessage = '매우 좋음';
      _advice = '운전가능한 수준입니다.';
      _progressBarColor = ColorStyles.primary;
    } else if (_alcoholLevel <= 0.05) {
      _resultMessage = '좋음';
      _advice = '면허 정지 수준입니다. \n운전을 하실 수 없습니다.';
      _progressBarColor = Colors.green;
    } else if (_alcoholLevel <= 0.08) {
      _resultMessage = '보통';
      _advice = '면허 취소 수준입니다. \n 운전을 하실 수 없습니다. ';
      _progressBarColor = Colors.amber;
    } else if (_alcoholLevel <= 0.10) {
      _resultMessage = '나쁨';
      _advice = '면허 취소 수준입니다. \n 운전을 하실 수 없습니다.';
      _progressBarColor = Colors.orange;
    } else {
      _resultMessage = '위험';
      _advice = '즉시 조치가 필요합니다.';
      _progressBarColor = Colors.red;
    }
  }

  String getCurrentDateTime() {
    final DateTime now = DateTime.now();
    final String period = now.hour >= 12 ? '오후' : '오전'; // 오전/오후 판별
    final int hour = now.hour % 12; // 12시간제로 변환
    final int displayHour = hour == 0 ? 12 : hour; // 0시를 12시로 변경

    return '${now.year}.${now.month}.${now.day} $period ${displayHour}:${now.minute}';
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
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  getCurrentDateTime(),
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 음주 측정 결과 카드
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: ColorStyles.grey, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "측정 결과",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 100),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: _progressBarColor,
                          ),
                          Text(
                            _resultMessage,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _progressBarColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_alcoholLevel.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 40, // Larger size for the number
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          // Space between number and percent symbol
                          Text(
                            '%',
                            style: TextStyle(
                              fontSize: 24,
                              // Smaller size for the percent symbol
                              fontWeight: FontWeight.w400,
                              color:
                                  Color(0xFF6B7280), // Gray color for percent
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: _alcoholLevel / 0.10,
                        backgroundColor: Color(0xFFF3F4F6),
                        valueColor:
                            AlwaysStoppedAnimation<Color>(_progressBarColor),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _advice,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 음주 운전 기준 카드 추가
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: ColorStyles.grey, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "음주 운전 기준",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '면허 정지',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '0.03% ~ 0.049%',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '면허 취소',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '0.05% 이상',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF9E9E9E),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // 음주 측정 화면으로 돌아가기
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: ColorStyles.primary),
                      fixedSize: Size(150, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      '다시측정',
                      style: TextStyle(
                        color: ColorStyles.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 메인 화면으로 돌아가기
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyles.primary,
                      fixedSize: Size(150, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
