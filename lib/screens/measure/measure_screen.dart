import 'dart:async';
import 'dart:typed_data';

import 'package:NCSensor/screens/result/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

import '../../constants/styles.dart';
import '../../routes/fade_page_route.dart';
import '../../widgets/ncs_app_bar.dart';
import 'widgets/action_button.dart';
import 'widgets/progress_circle.dart';
import 'widgets/sensor_status_card.dart';

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
  MeasureStatus measureStatus = MeasureStatus.ready;
  final Color sensorColor = ColorStyles.primary;
  final int limitSec = 10; // 몇 초 동안 측정하는지
  final double termSec = 1; // 몇 초마다 측정하는지

  //센서관련
  UsbPort? port;
  Transaction<String>? _transaction;
  StreamSubscription<String>? _subscription;

  List<Map<String, dynamic>> _testSensors = [
    // {"sensor_id": "1", "value": 0, "measured_at": "2025-01-22T00:00:00"},
    // {"sensor_id": "2", "value": 2, "measured_at": "2025-01-22T00:00:00"},
    // {"sensor_id": "3", "value": 3, "measured_at": "2025-01-22T00:00:00"},
    // {"sensor_id": "4", "value": 5, "measured_at": "2025-01-22T00:00:00"},
  ];

  Future<void> _startMeasurement() async {
    if (!mounted || measureStatus != MeasureStatus.ready) return;
    setState(() => measureStatus = MeasureStatus.measuring);
    _startListenSensor();
    for (int i = 1; i <= limitSec; i++) {
      if (!mounted) return;
      int termMilli = (termSec * 1000).toInt(); // 측정 텀을 밀리세크로 변환
      await Future.delayed(Duration(milliseconds: termMilli));
      print("Measuring... $i sec");
    }
    if (!mounted) return;
    setState(() => measureStatus = MeasureStatus.done);
    _navigateToResult();
  }

  Future<void> _startListenSensor() async {
    if (port == null) return;
    await port!.setDTR(true);
    await port!.setRTS(true);
    await port!.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(
        port!.inputStream as Stream<Uint8List>, Uint8List.fromList([13, 10]));

    _subscription = _transaction!.stream.listen((String line) {
      if (measureStatus == MeasureStatus.done || !mounted) {
        _subscription?.cancel();
        return;
      }
      _testSensors.add({
        "sensor_id": "1",
        "value": line,
      });
      setState(() {});
    });
    _subscription?.onDone(() {
      print("Done");
      if (!mounted) return;
    });
  }

  void _navigateToResult() {
    Navigator.pushReplacement(
        context,
        FadePageRoute(
            page: ResultScreen(
                articleId: widget.articleId, sensors: _testSensors)));
  }

  setMeasureStatus(MeasureStatus status) {
    if (!mounted) return;
    setState(() => measureStatus = status);
  }

  setPort(UsbPort port) {
    if (!mounted) return;
    setState(() => this.port = port);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _transaction?.dispose();
    port?.close();
    super.dispose();
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
                limitSec: limitSec,
                status: measureStatus,
              ),
              SensorStatusCard(
                status: measureStatus,
                setMeasureStatus: setMeasureStatus,
                setPort: setPort,
              ),
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
