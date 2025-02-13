import 'package:flutter/material.dart';
import '../../../constants/styles.dart';

import 'package:percent_indicator/percent_indicator.dart';

class ProgressCircle extends StatelessWidget {
  final double progress;
  final int second;

  const ProgressCircle({super.key, required this.progress,required this.second});

  @override
  Widget build(BuildContext context) {
    final size = SizeStyles.getMediaWidth(context, 0.3);
    return CircularPercentIndicator(
      radius: size,
      percent: progress,
      lineWidth: 15,
      backgroundColor: ColorStyles.lightgrey,
      progressColor: ColorStyles.primary,
      center: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${(progress * 100).toInt()}%',
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
