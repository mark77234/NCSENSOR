import 'package:flutter/material.dart';
import '../../../constants/styles.dart';

class ProgressCircle extends StatelessWidget {
  final double progress;

  const ProgressCircle({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.4;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 230,),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ],
          ),
          child:
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 18,
            backgroundColor: ColorStyles.primary.withValues(alpha: 230,),
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
              style: TextStyle(
                fontSize: size * 0.1,
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    );
  }
}
