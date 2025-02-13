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
      return "측정 하기";
    } else {
      return "측정 완료";
    }
  }

  onPressedButton() {
    if (status == MeasureStatus.done) {
      return onNavigateToResult;
    } else if (status == MeasureStatus.ready) {
      return onStartMeasurement;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedButton,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorStyles.primary,
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
        style: TextStyle(fontFamily: "Pretendard"),
      ),
    );
  }
}
