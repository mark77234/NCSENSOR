import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taesung1/screens/breath_screen.dart';

import '../constants/styles.dart';

class AlcoholResultScreen extends StatefulWidget {
  final String measurement;
  final String bodyMeasurement;
  final List<String> receivedData;

  const AlcoholResultScreen(
      {super.key,
      required this.measurement,
      required this.bodyMeasurement,
      required this.receivedData});

  @override
  State<AlcoholResultScreen> createState() => _AlcoholResultScreenState();
}

class _AlcoholResultScreenState extends State<AlcoholResultScreen> {
  // 혈중 알코올 농도 (랜덤 값)
  late double alcoholData;

  late String _resultMessage;
  late String _advice;
  late Color _progressBarColor;

  // <기준>
  // 안전 : 3500 미만, LED 작동 X
  // 경고 : 3500 이상, LED 작동 O (300ms)
  // 위험 : 3800 이상, LED 작동 O (100ms)
  // "
  List<double> threshold = [1500, 2000, 4500];

  @override
  void initState() {
    super.initState();
    log(widget.receivedData.toString());
    alcoholData = alcoholResult();
    _setAlcoholStage();
  }

  double _calculateAverageOfMiddleFive(List<double> data) {
    data.sort();
    if (data.length < 5) {
      return data.reduce((a, b) => a + b) / data.length;
    }
    int start = (data.length - 5) ~/ 2;
    List<double> middleFive = data.sublist(start, start + 5);
    return middleFive.reduce((a, b) => a + b) / middleFive.length;
  }

  double alcoholResult() {
    List<double> numericData =
        widget.receivedData.map((e) => double.tryParse(e) ?? 0.0).toList();
    double result = _calculateAverageOfMiddleFive(numericData);
    // result = threshold[2] - result;

    return result;
  }

  void _setAlcoholStage() {
    if (alcoholData <= threshold[0]) {
      _resultMessage = '정상';
      _advice = '운전가능한 수준입니다.';
      _progressBarColor = ColorStyles.primary;
    } else if (alcoholData <= threshold[1]) {
      _resultMessage = '면허정지';
      _advice = '면허 정지 수준입니다. \n운전을 하실 수 없습니다.';
      _progressBarColor = Color(0xFFF4C837);
    } else {
      _resultMessage = '면허취소';
      _advice = '면허 취소 수준입니다. \n 운전을 하실 수 없습니다.';
      _progressBarColor = Colors.red;
    }
  }

  String getCurrentDateTime() {
    final DateTime now = DateTime.now();
    final String period = now.hour >= 12 ? '오후' : '오전';
    final int hour = now.hour % 12;
    final int displayHour = hour == 0 ? 12 : hour;

    return '${now.year}.${now.month}.${now.day} $period $displayHour:${now.minute}';
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
            size: 30.0,
          ), // 홈 아이콘
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
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
                            alcoholData.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'ppm',
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
                        value: alcoholData / threshold[2],
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
                            '${threshold[0]} ~ ${threshold[1]}ppm 미만',
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
                            '${threshold[1]}ppm 이상',
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BreathScreen(
                                measurement: widget.measurement,
                                bodyMeasurement: widget.bodyMeasurement)),
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
                      Navigator.popUntil(context, (route) => route.isFirst);
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
