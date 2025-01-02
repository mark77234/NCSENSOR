import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/styles.dart';

class BodyResultScreen extends StatefulWidget {
  final String measurement; // 체취 부위

  const BodyResultScreen({super.key, required this.measurement});

  @override
  _BodyResultScreenState createState() => _BodyResultScreenState();
}

class _BodyResultScreenState extends State<BodyResultScreen> {

  @override
  Widget build(BuildContext context) {
    String resultMessage;
    int stage = Random().nextInt(5) + 1; // 1부터 5까지 랜덤으로 선택

    // 체취 단계에 따른 메시지 설정
    switch (stage) {
      case 1:
        resultMessage = '쾌적한 수준';
        break;
      case 2:
        resultMessage = '약간 불쾌한 수준';
        break;
      case 3:
        resultMessage = '불쾌한 수준';
        break;
      case 4:
        resultMessage = '많이 불쾌한 수준';
        break;
      case 5:
        resultMessage = '악취 수준';
        break;
      default:
        resultMessage = '체취 측정 결과를 확인할 수 없습니다.';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "체취 측정 결과",
          style: TextStyles.title,
        ),
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
            // 단계에 따른 메시지 표시
            Text(
              resultMessage,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // 1부터 5까지의 큰 숫자와 반투명 동그라미 이동
            Stack(
              alignment: Alignment.center,
              children: [
                // 동그라미 배경
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index < stage
                            ? Colors.blue
                            : Colors.grey.withValues(alpha: 0.3),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: index < stage ? Colors.white : Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}