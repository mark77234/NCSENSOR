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

  @override
  void initState() {
    super.initState();
  }

  Future<void> _startMeasurement(BuildContext context) async {
    setState(() => _isLoading = true);

    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      setState(() => _progress = i / 100);
      if (i == 100) _navigateToResult(context);
    }

    setState(() => _isLoading = false);
  }

  void _navigateToResult(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(widget.UUID),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProgressCircle(progress: _progress),
              const SizedBox(height: 40),
              SensorStatusCard(status: sensorStatus, color: sensorColor),
              const SizedBox(height: 50),
              ActionButton(
                isLoading: _isLoading,
                isCompleted: _progress >= 1.0,
                onNavigateToResult: () => _navigateToResult(context),
                onStartMeasurement: () => _startMeasurement(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
