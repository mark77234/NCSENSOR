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
  @override
  Widget build(BuildContext context) {
    String resultMessage;
    int stage = Random().nextInt(5) + 1; // 1부터 5까지 랜덤으로 선택

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '체취 측정이 완료되었습니다.',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              resultMessage,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Stack(
              alignment: Alignment.center,
              children: [
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
                            : Colors.grey.withOpacity(0.3),
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