import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../../../models/data/statistic_model.dart';
import '../../../models/meta/statistic_model.dart';
import '../../../widgets/my_card.dart';

class CompareContent extends StatelessWidget {
  const CompareContent(
      {super.key, required this.data, required this.meta, this.height = 300});

  final ComparisonData data;
  final StatCompareMeta meta;
  final double height;

  @override
  Widget build(BuildContext context) {
    num diff = meta.max - meta.min;
    String percentText;

    if (data.lastMonth > 0 && data.lastMonth > 0) {
      num percent = (data.currentMonth - data.lastMonth) / data.lastMonth * 100;
      percentText = "${percent.toStringAsFixed(1)}${meta.unit}";
    } else {
      percentText = "신규";
    }

    return MyCard(
        child: SizedBox(
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 8),
          Text(
            meta.title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(data.lastMonth.toString(),
                            style: TextStyles.title),
                        Container(
                          color: Color(0xFF85B5FD),
                          width: 40,
                          height: height * 0.6 * data.lastMonth / diff,
                        ),
                        Text("지난 달", style: TextStyles.label),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(data.currentMonth.toString(),
                            style: TextStyles.title),
                        Container(
                          color: ColorStyles.primary,
                          width: 40,
                          height: height * 0.6 * data.currentMonth / diff,
                        ),
                        Text("이번 달", style: TextStyles.label),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      percentText,
                      style:
                          TextStyles.title.copyWith(color: ColorStyles.primary),
                    ),
                    if (percentText != "신규") Text("지난 달 대비")
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    ));
  }
}
