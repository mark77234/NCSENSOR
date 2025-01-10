import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/styles.dart';
import 'main_screen.dart'; // MainScreen 임포트

class BodyResultScreen extends StatefulWidget {
  final String measurement;

  const BodyResultScreen({super.key, required this.measurement});

  @override
  _BodyResultScreenState createState() => _BodyResultScreenState();
}

class _BodyResultScreenState extends State<BodyResultScreen> {
  String getCurrentDateTime() {
    final DateTime now = DateTime.now();
    final String period = now.hour >= 12 ? '오후' : '오전'; // 오전/오후 판별
    final int hour = now.hour % 12; // 12시간제로 변환
    final int displayHour = hour == 0 ? 12 : hour; // 0시를 12시로 변경

    return '${now.year}.${now.month}.${now.day} $period ${displayHour}:${now.minute}';
  }

  @override
  Widget build(BuildContext context) {
    int stage = Random().nextInt(5) + 1; // 1부터 5까지 랜덤으로 선택
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
          "${widget.measurement} 냄새분석",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              // 현재 상태 카드
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
                            "현재 상태",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: _getStageColor(stage),
                          ),
                          Text(
                            resultMessage,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:
                                  _getStageColor(stage), // resultMessage 색상 변경
                            ),
                          ),
                          const SizedBox(height: 10),
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
                          const SizedBox(width: 8), // $stage와 "단계" 사이의 간격
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

              // 단계별 상태 카드
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
                    crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                    children: [
                      Align(
                        alignment: Alignment.topLeft, // 왼쪽 상단에 텍스트 배치
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
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // 왼쪽, 오른쪽 정렬
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
                                  _getStageMessage(index + 1), // 오른쪽 끝에 결과를 표시
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
              // 버튼들
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // breath_screen.dart로 이동
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
                        borderRadius: BorderRadius.circular(15), // 둥근 모서리 설정
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
                      // main_screen.dart로 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyles.primary,
                      fixedSize: Size(150, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // 둥근 모서리 설정
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

  Color _getStageColor(int stage) {
    switch (stage) {
      case 1:
        return ColorStyles.primary;
      case 2:
        return Colors.green;
      case 3:
        return Colors.amber;
      case 4:
        return Colors.orange;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStageMessage(int stage) {
    switch (stage) {
      case 1:
        return '매우 좋음';
      case 2:
        return '좋음';
      case 3:
        return '보통';
      case 4:
        return '나쁨';
      case 5:
        return '위험';
      default:
        return '상태를 확인할 수 없습니다.';
    }
  }
}
