import 'package:flutter/material.dart';

import '../../../constants/styles.dart';

class ProgressCircle extends StatelessWidget {
  final double progress;

  const ProgressCircle({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 180,
          height: 180,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 18,
            backgroundColor: ColorStyles.lightgrey,
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.lerp(ColorStyles.primary, ColorStyles.primary, progress) ??
                  ColorStyles.primary,
            ),
          ),
        ),
        Text(
          '${(progress * 100).toInt()}%',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color.lerp(
                ColorStyles.primary, ColorStyles.primary, progress) ??
                ColorStyles.primary,
          ),
        ),
      ],
    );
  }
}