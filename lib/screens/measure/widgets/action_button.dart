import 'package:NCSensor/screens/measure/measure_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/styles.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onStartMeasurement;
  final VoidCallback onNavigateToResult;
  final MeasureStatus status;

  const ActionButton({
    super.key,
    required this.onStartMeasurement,
    required this.onNavigateToResult,
    required this.status,
  });

  String buttonText() {
    if (status == MeasureStatus.measuring) {
      return "측정 중...";
    } else if (status == MeasureStatus.ready) {
      return "측정 시작";
    } else if (status == MeasureStatus.connecting) {
      return "연결 중...";
    } else if (status == MeasureStatus.disconnected) {
      return "측정 불가";
    } else {
      return "측정 완료";
    }
  }

  onPressedButton() {
    if (status == MeasureStatus.done) {
      onNavigateToResult();
    } else if (status == MeasureStatus.ready) {
      onStartMeasurement();
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedButton,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: status == MeasureStatus.disconnected
            ? ColorStyles.darkgrey
            : ColorStyles.lightgrey,
        backgroundColor: status == MeasureStatus.disconnected
            ? ColorStyles.lightgrey
            : ColorStyles.primary,
        disabledBackgroundColor: ColorStyles.lightgrey,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: MeasureTextStyles.main,
        minimumSize: Size(SizeStyles.getMediaWidth(context, 0.8), 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(
        buttonText(),
      ),
    );
  }
}
