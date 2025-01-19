import 'package:flutter/material.dart';

import '../constants/styles.dart';
import '../widgets/common/my_card.dart';
import 'alcohol_result_screen.dart';
import 'body_result_screen.dart';

class BreathScreen extends StatefulWidget {
  final String measurement;
  final String bodyMeasurement;

  const BreathScreen({
    super.key,
    required this.measurement,
    required this.bodyMeasurement,
  });

  @override
  State<BreathScreen> createState() => _BreathScreenState();
}

class _BreathScreenState extends State<BreathScreen> {
  bool _isLoading = false;
  double _progress = 0.0;

  Future<void> _startMeasurement(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      setState(() {
        _progress = i / 100;
      });
      if (i == 100) {
        _navigateToResult(context);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _navigateToResult(BuildContext context) {
    if (widget.measurement == "음주") {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AlcoholResultScreen(
                measurement: widget.measurement,
                bodymeasurement: widget.bodyMeasurement)),
      );
    } else if (widget.measurement == "체취") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BodyResultScreen(
              measurement: widget.measurement,
              bodyMeasurement: widget.bodyMeasurement),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "농도 측정",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: _progress,
                    strokeWidth: 18,
                    backgroundColor: Color(0xFFF3F4F6),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.lerp(
                              Colors.green, ColorStyles.primary, _progress) ??
                          ColorStyles.primary, // null 처리
                    ),
                  ),
                ),
                Text(
                  '${(_progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.lerp(
                            ColorStyles.grey, ColorStyles.primary, _progress) ??
                        ColorStyles.primary, // null 처리
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: MyCard(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "센서 상태",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 100),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: ColorStyles.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            "인식완료",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorStyles.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            ElevatedButton(
              onPressed: _progress < 1.0
                  ? () => _startMeasurement(context)
                  : () => _navigateToResult(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: _progress < 1.0
                    ? (_isLoading ? Colors.grey : Colors.white)
                    : Colors.white,
                backgroundColor: _progress < 1.0
                    ? (_isLoading ? ColorStyles.grey : ColorStyles.primary)
                    : ColorStyles.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                minimumSize: Size(300, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                _isLoading ? "측정중..." : "측정하기",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
