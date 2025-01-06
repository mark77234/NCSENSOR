import 'package:flutter/material.dart';
import '../constants/styles.dart';
import 'alcohol_result_screen.dart';
import 'body_result_screen.dart';

// BreathScreen을 StatefulWidget으로 변경
class BreathScreen extends StatefulWidget {
  final String measurement;
  final String bodymeasurement;

  const BreathScreen({
    super.key,
    required this.measurement,
    required this.bodymeasurement,
  });

  @override
  _BreathScreenState createState() => _BreathScreenState();
}

class _BreathScreenState extends State<BreathScreen> {

  Future<void> _navigateWithLoading(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2C46BD)),
                ),
                const SizedBox(height: 20),
                Text(
                  "측정중입니다...",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 3));

    Navigator.pop(context);

    if (widget.measurement == "음주") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AlcoholResultScreen()),
      );
    } else if (widget.measurement == "체취") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BodyResultScreen(measurement: widget.bodymeasurement),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "측정",
          style: TextStyles.title,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.bodymeasurement} 측정을 시작합니다',
              style: const TextStyle(fontSize: 24),
            ),
            Icon(
              Icons.air,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              '3초간 센서에 바람을 불어주세요',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 40), // 버튼 위에 간격 추가
            ElevatedButton(
              onPressed: () => _navigateWithLoading(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ColorStyles.primary,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              child: const Text("시작하기"),
            ),
          ],
        ),
      ),
    );
  }
}