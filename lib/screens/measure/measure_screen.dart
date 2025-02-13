import 'package:NCSensor/animation/fade_page_route.dart';
import 'package:NCSensor/widgets/common/ncsAppBar.dart';
import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import '../../widgets/screens/measure/action_button.dart';
import '../../widgets/screens/measure/progress_circle.dart';
import '../../widgets/screens/measure/sensor_status_card.dart';
import 'result_screen.dart';

class MeasureScreen extends StatefulWidget {
  final String UUID;

  const MeasureScreen(this.UUID, {super.key});

  @override
  State<MeasureScreen> createState() => _MeasureScreenState();
}

class _MeasureScreenState extends State<MeasureScreen> {
  bool _isLoading = false;
  double _progress = 0.0;
  final String sensorStatus = "인식완료";
  final Color sensorColor = ColorStyles.primary;

  static const _testSensors = [
    {"sensor_id": "1", "value": 0, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "2", "value": 2, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "3", "value": 3, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "4", "value": 5, "measured_at": "2025-01-22T00:00:00"},
  ];

  Future<void> _startMeasurement() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      if (!mounted) return;
      setState(() => _progress = i / 100);
      if (i == 100 && mounted) {
        _navigateToResult();
      }
    }
    setState(() => _isLoading = false);
  }

  void _navigateToResult() {
    Navigator.pushReplacement(
      context,
      FadePageRoute(page: ResultScreen(articleId: widget.UUID, sensors: _testSensors))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NCSAppBar(title: "측정"),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProgressCircle(progress: _progress),
              SensorStatusCard(status: sensorStatus, color: sensorColor),
              ActionButton(
                isLoading: _isLoading,
                isCompleted: _progress >= 1.0,
                onNavigateToResult: _navigateToResult,
                onStartMeasurement: _startMeasurement,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
