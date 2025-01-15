import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taesung1/screens/breath_screen.dart';
import 'package:taesung1/screens/main_screen.dart';
import '../constants/styles.dart';

class AlcoholResultScreen extends StatefulWidget {
  final String measurement;
  final String bodymeasurement;

  const AlcoholResultScreen(
      {super.key, required this.measurement, required this.bodymeasurement});

  @override
  State<AlcoholResultScreen> createState() => _AlcoholResultScreenState();
}

class _AlcoholResultScreenState extends State<AlcoholResultScreen> {

  // 혈중 알코올 농도 (랜덤 값)
  double _alcoholLevel = Random().nextDouble() * 0.10;

  String _resultMessage = '';
  String _advice = '';
  Color _progressBarColor = Colors.green;

  @override
  void initState() {
    super.initState();
    _setAlcoholStage();
  }

  void _setAlcoholStage() {
    if (_alcoholLevel <= 0.03) {
      _resultMessage = '정상';
      _advice = '운전가능한 수준입니다.';
      _progressBarColor = ColorStyles.primary;
    } else if (_alcoholLevel <= 0.05) {
      _resultMessage = '면허정지';
      _advice = '면허 정지 수준입니다. \n운전을 하실 수 없습니다.';
      _progressBarColor = Colors.green;
    } else if (_alcoholLevel <= 0.08) {
      _resultMessage = '면허취소';
      _advice = '면허 취소 수준입니다. \n 운전을 하실 수 없습니다. ';
      _progressBarColor = Colors.amber;
    } else if (_alcoholLevel <= 0.10) {
      _resultMessage = '면허취소';
      _advice = '면허 취소 수준입니다. \n 운전을 하실 수 없습니다.';
      _progressBarColor = Colors.orange;
    } else {
      _resultMessage = '면허취소';
      _advice = '즉시 조치가 필요합니다.';
      _progressBarColor = Colors.red;
    }
  }

  String getCurrentDateTime() {
    final DateTime now = DateTime.now();
    final String period = now.hour >= 12 ? '오후' : '오전';
    final int hour = now.hour % 12;
    final int displayHour = hour == 0 ? 12 : hour;

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
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '%',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BreathScreen(
                                measurement: widget.measurement,
                                bodymeasurement: widget.bodymeasurement)),
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
