import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/screens/measure/widgets/status_indicator.dart';
import 'package:flutter/material.dart';

import '../measure_screen.dart';

class SensorStatusCard extends StatelessWidget {
  final MeasureStatus status;

  const SensorStatusCard({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeStyles.getMediaWidth(context, 0.8),
      decoration: ContainerStyles.card,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("센서 상태",
              style: MeasureTextStyles.sub.copyWith(
                fontSize: 18,
              )),
          StatusIndicator(status: status),
        ],
      ),
    );
  }
}
