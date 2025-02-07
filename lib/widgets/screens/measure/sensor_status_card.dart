import 'package:NCSensor/constants/styles.dart';
import 'package:flutter/material.dart';

class SensorStatusCard extends StatelessWidget {
  final String status;
  final Color color;

  const SensorStatusCard({
    super.key,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerStyles.card,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "센서 상태",
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          _buildStatusIndicator(context),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
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
              border: Border.all(
                color: color.computeLuminance() > 0.4
                    ? Colors.black26
                    : Colors.transparent,
                width: 1.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
