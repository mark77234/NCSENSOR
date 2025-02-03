import 'package:flutter/material.dart';

import '../../../../../constants/styles.dart';

class BreathProgressIndicator extends StatelessWidget {
  const BreathProgressIndicator({super.key, required this.progress});

  final double progress;

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
            backgroundColor: Color(0xFFF3F4F6),
            valueColor: AlwaysStoppedAnimation<Color>(
              Color.lerp(Colors.green, ColorStyles.primary, progress) ??
                  ColorStyles.primary,
            ),
          ),
        ),
        Text(
          '${(progress * 100).toInt()}',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color:
                Color.lerp(ColorStyles.lightgrey, ColorStyles.primary, progress) ??
                    ColorStyles.primary,
          ),
        ),
      ],
    );
  }
}
