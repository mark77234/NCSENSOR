import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../measure_screen.dart';

class StatusIndicator extends StatelessWidget {
  final MeasureStatus status;

  const StatusIndicator({super.key, required this.status});

  Color get color {
    switch (status) {
      case MeasureStatus.connecting:
        return Colors.yellow;
      case MeasureStatus.disconnected:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  String getStatusToString() {
    switch (status) {
      case MeasureStatus.connecting:
        return "연결 중...";
      case MeasureStatus.disconnected:
        return "연결 끊김";
      default:
        return "준비 완료";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 230,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: color.withValues(
            alpha: 230,
          ),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(getStatusToString(),
              style: MeasureTextStyles.main.copyWith(
                color: color,
                fontSize: 18,
              )),
        ],
      ),
    );
  }
}
