import 'package:NCSensor/routes/fade_page_route.dart';
import 'package:NCSensor/widgets/common/ncs_app_bar.dart';
import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import '../../widgets/screens/measure/action_button.dart';
import '../../widgets/screens/measure/progress_circle.dart';
import '../../widgets/screens/measure/sensor_status_card.dart';
import 'result_screen.dart';

class MeasureScreen extends StatefulWidget {
  final String articleId;

  const MeasureScreen({super.key, required this.articleId});

  @override
  State<MeasureScreen> createState() => _MeasureScreenState();
}

enum MeasureStatus {
  connecting, // 센서 연결 중
  disconnected, // 센서 연결 끊김
  ready, // 측정 준비 완료
  measuring, // 측정 중
  done, // 측정 완료
}

class _MeasureScreenState extends State<MeasureScreen> {
  double _progress = 0.0;
  MeasureStatus measureStatus = MeasureStatus.connecting;
  final Color sensorColor = ColorStyles.primary;
  int second = 10; // 몇 초 동안 부는지

  static const _testSensors = [
    {"sensor_id": "1", "value": 0, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "2", "value": 2, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "3", "value": 3, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "4", "value": 5, "measured_at": "2025-01-22T00:00:00"},
  ];

  Future<void> _startMeasurement() async {
    if (!mounted) return;
    setState(() => measureStatus = MeasureStatus.measuring);

    for (int i = 1; i <= second; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      if (!mounted) return;
      setState(() => _progress = i / second);
      if (i == second && mounted) {
        _navigateToResult();
      }
    }
    setState(() => measureStatus = MeasureStatus.done);
  }

  void _navigateToResult() {
    Navigator.pushReplacement(
        context,
        FadePageRoute(
            page: ResultScreen(
                articleId: widget.articleId, sensors: _testSensors)));
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
              ProgressCircle(
                progress: _progress,
                second: second,
              ),
              SensorStatusCard(status: measureStatus),
              ActionButton(
                status: measureStatus,
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
