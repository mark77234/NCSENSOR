import 'dart:math';
import 'package:flutter/material.dart';
import 'package:taesung1/screens/breath_screen.dart';
import '../constants/styles.dart';
import 'main_screen.dart';
import 'package:taesung1/services/api_service.dart';
import 'package:taesung1/models/bodyresult_model.dart';

class BodyResultScreen extends StatefulWidget {
  final String bodymeasurement;
  final String measurement;

  const BodyResultScreen(
      {super.key, required this.bodymeasurement, required this.measurement});

  @override
  _BodyResultScreenState createState() => _BodyResultScreenState();
}

class _BodyResultScreenState extends State<BodyResultScreen> {
  List<BodyResultData>? bodyResultData;
  bool _isDataLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBodyResult();
  }

  Future<void> _loadBodyResult() async {
    setState(() {
      _isDataLoading = true;
    });
    try {
      final data = await ApiService.getBodyData();
      setState(() {
        bodyResultData = data;
      });
    } catch (e, s) {
      print('Error loading body result data: $e');
      print(s);
    }
    setState(() {
      _isDataLoading = false;
    });
  }

  String getCurrentDateTime() {
    final DateTime now = DateTime.now();
    final String period = now.hour >= 12 ? '오후' : '오전';
    final int hour = now.hour % 12;
    final int displayHour = hour == 0 ? 12 : hour;
    return '${now.year}.${now.month}.${now.day} $period $displayHour:${now.minute}';
  }

  String _getResultMessage(int stage) {
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
        return '체취 측정 결과를 확인할 수 없습니다.';
    }
  }

  String _getAdvice(int stage) {
    switch (stage) {
      case 1:
        return '현재 상태가 좋습니다.';
      case 2:
        return '조금 더 신경을 써주세요.';
      case 3:
        return '조금 개선이 필요합니다.';
      case 4:
        return '주의가 필요합니다.';
      case 5:
        return '즉시 조치가 필요합니다.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    int stage = Random().nextInt(5) + 1;
    String resultMessage = _getResultMessage(stage);
    String advice = _getAdvice(stage);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.bodymeasurement} 냄새분석",
          style: const TextStyle(
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
              if (_isDataLoading)
                const Center(child: CircularProgressIndicator())
              else
                Column(
                  children: [
                    Center(
                      child: Text(
                        getCurrentDateTime(),
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildResultCard(stage, resultMessage, advice),
                    const SizedBox(height: 20),
                    _buildStatusCard(),
                    const SizedBox(height: 20),
                    _buildActionButtons(context),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildResultCard(int stage, String resultMessage, String advice) {
    return Card(
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
                const Text(
                  '현재 상태',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: bodyResultData![stage - 1].color,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      resultMessage,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: bodyResultData![stage - 1].color,
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
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
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
              backgroundColor: const Color(0xFFF3F4F6),
              valueColor: AlwaysStoppedAnimation<Color>(
                  bodyResultData![stage - 1].color),
            ),
            const SizedBox(height: 10),
            Text(
              advice,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card _buildStatusCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
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
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: bodyResultData![index].color,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${index + 1}단계 ',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4B5563),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        bodyResultData![index].content,
                        style: const TextStyle(
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
    );
  }

  Row _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BreathScreen(
                  measurement: widget.measurement,
                  bodymeasurement: widget.bodymeasurement,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: ColorStyles.primary),
            fixedSize: const Size(150, 70),
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
                builder: (context) => const MainScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorStyles.primary,
            fixedSize: const Size(150, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text(
            '확인',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}