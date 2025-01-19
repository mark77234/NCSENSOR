import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taesung1/screens/breath_screen.dart';
import '../constants/styles.dart';
import 'main_screen.dart';

import 'package:taesung1/services/api_service.dart';
import 'package:dio/dio.dart';

class BodyResultScreen extends StatefulWidget {
  final String bodymeasurement;
  final String measurement;

  const BodyResultScreen(
      {super.key, required this.bodymeasurement, required this.measurement});

  @override
  State<BodyResultScreen> createState() => _BodyResultScreenState();
}

class _BodyResultScreenState extends State<BodyResultScreen> {
  late Future<Map<String, dynamic>> _stageMessagesFuture;
  late Map<String, dynamic> _stageMessages;

  String getCurrentDateTime() {
    final DateTime now = DateTime.now();
    final String period = now.hour >= 12 ? '오후' : '오전';
    final int hour = now.hour % 12;
    final int displayHour = hour == 0 ? 12 : hour;

    return '${now.year}.${now.month}.${now.day} $period $displayHour:${now.minute}';
  }

  @override
  void initState() {
    super.initState();
    _stageMessagesFuture = _fetchStageMessages();
  }

  Future<Map<String, dynamic>> _fetchStageMessages() async {
    Response response = await ApiService.getBodyResult();
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    int stage = Random().nextInt(5) + 1;
    String resultMessage;
    String advice;

    switch (stage) {
      case 1:
        resultMessage = '매우 좋음';
        advice = '현재 상태가 좋습니다.';
        break;
      case 2:
        resultMessage = '좋음';
        advice = '조금 더 신경을 써주세요.';
        break;
      case 3:
        resultMessage = '보통';
        advice = '조금 개선이 필요합니다.';
        break;
      case 4:
        resultMessage = '나쁨';
        advice = '주의가 필요합니다.';
        break;
      case 5:
        resultMessage = '위험';
        advice = '즉시 조치가 필요합니다.';
        break;
      default:
        resultMessage = '체취 측정 결과를 확인할 수 없습니다.';
        advice = '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.bodymeasurement} 냄새분석",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _stageMessagesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('에러 발생'));
          } else if (snapshot.hasData) {
            _stageMessages = snapshot.data!;
            return SingleChildScrollView(
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
                            fontWeight: FontWeight.bold),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 부모 Row에서 공간 분배
                              children: [
                                Text(
                                  '현재 상태',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: _getStageColor(stage),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      resultMessage,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: _getStageColor(stage),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$stage',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '단계',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Color(0xFF6B7280),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            LinearProgressIndicator(
                              value: stage / 5,
                              backgroundColor: Color(0xFFF3F4F6),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  _getStageColor(stage)),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              advice,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF6B7280),
                                fontWeight: FontWeight.bold,
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
                        side: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "단계별 상태",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              children: List.generate(5, (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 5,
                                            backgroundColor:
                                                _getStageColor(index + 1),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            '${index + 1}단계 ',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xFF4B5563),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        _stageMessages['level']['sections']
                                                [index]['content'] ??
                                            '상태를 확인할 수 없습니다.',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF4B5563),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()),
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
            );
          } else {
            return Center(child: Text('데이터를 불러오는 중...'));
          }
        },
      ),
    );
  }

  Color _getStageColor(int stage) {
    if (_stageMessages.isNotEmpty) {
      try {
        String stageColor = _stageMessages['level']['sections'][stage - 1]
                ['color'] ??
            '0xFF808080';
        return Color(int.parse(stageColor));
      } catch (e) {
        return Colors.grey;
      }
    }
    return Colors.grey;
  }
}
