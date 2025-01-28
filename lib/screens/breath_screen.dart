import 'package:flutter/material.dart';

import '../constants/styles.dart';
import '../widgets/common/my_card.dart';
import '../widgets/screens/breath/breath_progress_indicator.dart';
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

enum BreathState {
  initial, // 센서 연결 중
  ready, // 측정 준비 완료
  measuring, // 측정 중
  done, // 측정 완료
}

class _BreathScreenState extends State<BreathScreen> {
  BreathState _breathState = BreathState.ready;
  double _progress = 0.0;
  final double _blowLimitSec = 10.0;

  Future<void> _showBlowDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // Prevents dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('측정 준비'),
          content: const Text('10초 동안 불어주세요.'),
          actions: <Widget>[
            TextButton(
              child: const Text('확인'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _startMeasurement(BuildContext context) async {
    setState(() {
      _breathState = BreathState.measuring;
    });

    await _showBlowDialog(context);
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: _blowLimitSec * 1000 ~/ 100));
      setState(() {
        _progress = i / 100;
      });
    }
    await Future.delayed(const Duration(milliseconds: 50));

    _navigateToResult(context);
  }

  void _navigateToResult(BuildContext context) {
    if (!mounted) return;
    if (widget.measurement == "음주") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AlcoholResultScreen(
                measurement: widget.measurement,
                bodyMeasurement: widget.bodyMeasurement)),
      );
    } else if (widget.measurement == "체취") {
      Navigator.pushReplacement(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BreathProgressIndicator(progress: _progress),
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
            _buildBreathButton(context),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreathButton(BuildContext context) {
    bool isMeasuring = _breathState == BreathState.measuring;
    return ElevatedButton(
      onPressed: () =>
          {_startMeasurement(context).then((_) => _navigateToResult(context))},
      style: ElevatedButton.styleFrom(
        foregroundColor: isMeasuring ? Colors.grey : Colors.white,
        backgroundColor: isMeasuring ? ColorStyles.grey : ColorStyles.primary,
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
        isMeasuring ? "측정중..." : "측정하기",
      ),
    );
  }
}
