import 'package:flutter/material.dart';

class BodyResult extends StatelessWidget {
  final String measurement; // 체취 부위

  const BodyResult({super.key, required this.measurement});

  @override
  Widget build(BuildContext context) {
    String resultMessage;

    // measurement에 따라 다른 결과 메시지 설정
    switch (measurement) {
      case '입 체취':
        resultMessage = '입에서 측정된 체취: 정상';
        break;
      case '발 체취':
        resultMessage = '발에서 측정된 체취: 약간의 냄새 감지';
        break;
      case '겨드랑이 체취':
        resultMessage = '겨드랑이에서 측정된 체취: 강한 체취 감지';
        break;
      default:
        resultMessage = '체취 측정 결과를 확인할 수 없습니다.';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("체취 측정 결과"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '체취 측정이 완료되었습니다.',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            // measurement에 따라 다른 결과 메시지 표시
            Text(
              resultMessage,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 이전 페이지로 돌아가기
                Navigator.pop(context);
              },
              child: const Text("돌아가기"),
            ),
          ],
        ),
      ),
    );
  }
}