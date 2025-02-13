import 'package:flutter/material.dart';
import '../../../constants/styles.dart';

class ProgressCircle extends StatelessWidget {
  final double progress;

  const ProgressCircle({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final size = SizeStyles.getMediaWidth(context, 0.6);
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child:
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 18,
            backgroundColor: ColorStyles.lightgrey,
            valueColor: const AlwaysStoppedAnimation<Color>(
              ColorStyles.primary,
            ),
          ),
        ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${(progress * 100).toInt()}%',
              style: TextStyles.progressPercentage.copyWith(
                fontSize: size * 0.25,
                fontWeight: FontWeight.w800,
                color: ColorStyles.primary,
              ),
            ),
            SizedBox(height: size * 0.05),
            Text(
              '진행률',
              style: MeasureTextStyles.sub.copyWith(fontSize: size * 0.1,)
            ),
          ],
        )
      ],
    );
  }
}
