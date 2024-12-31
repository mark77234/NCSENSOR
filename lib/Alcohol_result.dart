import 'package:flutter/material.dart';

class AlcoholResult extends StatelessWidget {
  const AlcoholResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("음주 측정 결과"),
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
            // 음주 측정 결과를 여기에 표시 (예시)
            const Text(
              '측정 결과: 0.05%',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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