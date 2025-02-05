import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../../../models/ui/article_model.dart';

class ResultCard extends StatelessWidget {
  final int stage;
  final Result result;
  final List<Section> sections;
  final double value;
  final String? unit;
  final String? comment;

  const ResultCard({
    super.key,
    required this.stage,
    required this.result,
    required this.sections,
    required this.value,
    this.unit,
    this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: ColorStyles.lightgrey, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '현재 상태',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: sections[stage].color,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      sections[stage].name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: sections[stage].color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${value}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  unit ?? '',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: value / result.max,
              backgroundColor: const Color(0xFFF3F4F6),
              valueColor: AlwaysStoppedAnimation<Color>(sections[stage].color),
            ),
            const SizedBox(height: 10),
            Text(
              comment!,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
