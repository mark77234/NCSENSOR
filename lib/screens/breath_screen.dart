import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../constants/styles.dart';
import '../widgets/common/simple_alert_dialog.dart';
import '../widgets/screens/breath/breath_progress_indicator.dart';
import '../widgets/screens/breath/sensor_status_box.dart';
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
  BluetoothCharacteristic? _characteristic;
  BreathState _breathState = BreathState.initial;
  double _progress = 0.0;
  final double _blowLimitSec = 10.0;
  List<String> receivedData = [];

  void _onSensorAssigned(BluetoothCharacteristic characteristic) {
    setState(() {
      _characteristic = characteristic;
      _breathState = BreathState.ready;
    });
  }

  void _onLostConnection() {
    setState(() {
      _characteristic = null;
      _breathState = BreathState.initial;
    });
    showSimpleAlert(
      context,
      title: "연결 끊김",
      content: "센서와 연결이 끊겼습니다. 다시 연결해주세요.",
    );
  }

  Future<void> _startMeasurement(BuildContext context) async {
    if (_characteristic == null) return;
    setState(() {
      _breathState = BreathState.measuring;
    });
    await showSimpleAlert(
      context,
      title: "측정 시작",
      content: "10초 동안 불어주세요.",
    );
    for (int i = 1; i <= _blowLimitSec; i++) {
      await Future.delayed(Duration(seconds: 1));
      if (_characteristic != null) {
        List<int> data = await _characteristic!.read();
        log(data.toString());
        String dataString = String.fromCharCodes(data);
        log(dataString);
        if (mounted) {
          setState(() {
            receivedData.add(dataString);
            _progress = i / 10;
          });
        }
      }
    }
    setState(() {
      _breathState = BreathState.done;
    });
    await Future.delayed(const Duration(milliseconds: 50));
  }

  void _navigateToResult(BuildContext context) {
    if (!mounted) return;
    if (widget.measurement == "음주") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AlcoholResultScreen(
                measurement: widget.measurement,
                bodyMeasurement: widget.bodyMeasurement,
                receivedData: receivedData)),
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
            SensorStatusBox(
              onSensorAssigned: _onSensorAssigned,
              onLostConnection: _onLostConnection,
              characteristic: _characteristic,
            ),
            const SizedBox(height: 70),
            if (_breathState != BreathState.initial)
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
