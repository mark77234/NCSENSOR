import 'package:flutter/material.dart';

import '../../../constants/styles.dart';

class ActionButton extends StatelessWidget {
  final bool isLoading;
  final bool isCompleted;
  final VoidCallback onStartMeasurement;
  final VoidCallback onNavigateToResult;

  const ActionButton({
    super.key,
    required this.isLoading,
    required this.isCompleted,
    required this.onStartMeasurement,
    required this.onNavigateToResult,
  });

  @override
  Widget build(BuildContext context) {
    final buttonText = isLoading
        ? "측정 중..."
        : isCompleted
            ? "결과 보기"
            : "측정 하기";

    return ElevatedButton(
      onPressed: isLoading
          ? null
          : isCompleted
              ? onNavigateToResult
              : onStartMeasurement,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor:
            isCompleted ? ColorStyles.secondary : ColorStyles.primary,
        disabledBackgroundColor: ColorStyles.lightgrey,
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        minimumSize: Size(SizeStyles.getMediaWidth(context, 0.8), 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(buttonText,
      style: TextStyle(fontFamily: "DoHyeon"),),
    );
  }
}
