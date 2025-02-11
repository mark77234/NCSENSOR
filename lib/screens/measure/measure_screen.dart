import 'package:NCSensor/widgets/screens/main/ncsAppBar.dart';
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

  Future<void> _startMeasurement() async {
    setState(() => _isLoading = true);

    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      if (mounted) {
        setState(() => _progress = i / 100);
      }
      if (i == 100) _navigateToResult();
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToResult() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ResultScreen(widget.UUID),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:NCSAppBar(title: "측정"),
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
