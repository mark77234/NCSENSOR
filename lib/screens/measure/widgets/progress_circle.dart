import 'dart:async';

import 'package:NCSensor/screens/measure/measure_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../constants/styles.dart';

class ProgressCircle extends StatefulWidget {
  final int limitSec;
  final MeasureStatus status;

  const ProgressCircle(
      {super.key, required this.limitSec, required this.status});

  @override
  State<ProgressCircle> createState() => _ProgressCircleState();
}

class _ProgressCircleState extends State<ProgressCircle> {
  double _percent = 1.0;
  Timer? _timer;

  @override
  void didUpdateWidget(ProgressCircle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status == oldWidget.status) return;
    if (oldWidget.status == MeasureStatus.ready &&
        widget.status == MeasureStatus.measuring) {
      _startProgress();
    } else if (widget.status != MeasureStatus.measuring ||
        widget.status != MeasureStatus.done) {
      _stopProgress();
      // 측정중과 측정완료가 아니라면 측정 중지
    }
  }

  void _startProgress() {
    _stopProgress(); // 기존 타이머 정리
    setState(() => _percent = 1.0);

    final interval = Duration(milliseconds: 50); // 50ms 마다 업데이트
    final step = 1 / (widget.limitSec * 1000 / interval.inMilliseconds);

    _timer = Timer.periodic(interval, (timer) {
      if (!mounted) return;
      setState(() {
        if (_percent <= 0.0) {
          _stopProgress();
        } else {
          _percent -= step;
          if (_percent <= 0){
            _percent = 0;
          }
        }
      });
    });
  }

  void _stopProgress() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopProgress();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = SizeStyles.getMediaWidth(context, 0.3);

    return CircularPercentIndicator(
      radius: size,
      percent: _percent > 1.0 ? 1.0 : _percent,
      lineWidth: 15,
      backgroundColor: ColorStyles.lightgrey,
      progressColor: ColorStyles.primary,
      center: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${(_percent * widget.limitSec).toDouble().toStringAsFixed(1)}초',
            style: TextStyles.progressPercentage.copyWith(
              fontSize: size * 0.4,
              fontWeight: FontWeight.w800,
              color: ColorStyles.primary,
            ),
          ),
          SizedBox(height: size * 0.05),
          Text('진행률',
              style: MeasureTextStyles.sub.copyWith(
                fontSize: size * 0.2,
              )),
        ],
      ),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
