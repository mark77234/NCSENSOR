import 'package:flutter/material.dart';
import 'Measure.dart'; // 다음 화면 import

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인 화면'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 버튼 클릭 시 다음 화면으로 전환
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Measure()),
            );
          },
          child: const Text('다음 화면으로 이동'),
        ),
      ),
    );
  }
}