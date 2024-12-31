import 'package:flutter/material.dart';
import 'Alcohol_result.dart'; // 음주 측정 결과 페이지
import 'Body_result.dart'; // 체취 측정 결과 페이지

class Breath extends StatelessWidget {
  final String measurement;
  final String bodymeasurement;

  const Breath({
    super.key,
    required this.measurement,
    required this.bodymeasurement,
  });

  Future<void> _navigateWithLoading(BuildContext context) async {
    // 로딩 다이얼로그 표시
    showDialog(
      context: context,
      barrierDismissible: false, // 다이얼로그 외부 클릭으로 닫히지 않도록 설정
      builder: (context) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(), // 로딩 스피너
              SizedBox(height: 20), // 텍스트와 로딩 스피너 사이 간격
              Text(
                "측정중입니다...",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey, // 텍스트 색상 회색으로 설정
                  decoration: TextDecoration.none, // 밑줄 제거
                ),
              ),
            ],
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 5));

    // 다이얼로그 닫기
    Navigator.pop(context);

    // 측정 항목에 따라 결과 페이지로 이동
    if (measurement == "음주") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AlcoholResult()),
      );
    } else if (measurement == "체취") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BodyResult(measurement: bodymeasurement),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("측정 진행"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$bodymeasurement 측정을 시작합니다.',
              style: const TextStyle(fontSize: 24),
            ),
            // 입김을 부는 아이콘
            Icon(
              Icons.air,
              size: 100, // 아이콘 크기
              color: Colors.blue, // 아이콘 색상
            ),
            const SizedBox(height: 20),
            // 3초간 센서에 바람을 불어주세요 텍스트
            const Text(
              '3초간 센서에 바람을 불어주세요.',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      // 오른쪽 밑에 버튼 추가
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateWithLoading(context),
        child: const Icon(Icons.arrow_forward),
        backgroundColor: Colors.blue,
      ),
    );
  }
}