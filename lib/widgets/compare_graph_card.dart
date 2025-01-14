import 'package:flutter/material.dart';
import 'package:taesung1/models/measure_model.dart';

import '../constants/styles.dart';
import 'my_card.dart';

class CompareGraphCard extends StatelessWidget {
  const CompareGraphCard(
      {super.key,
      required this.item,
      required this.maxValue,
      required this.height});

  final CompareGraphData item;
  final double maxValue;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MyCard(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 8),
        Text(
          item.title,
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
                      Text(item.lastMonth.toString(), style: TextStyles.title),
                      Container(
                        color: ColorStyles.primary.withAlpha(100),
                        width: 40,
                        height: height * 0.6 * item.lastMonth / maxValue,
                      ),
                      Text("지난달", style: TextStyles.label),
                    ],
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(item.thisMonth.toString(), style: TextStyles.title),
                      Container(
                        color: ColorStyles.primary,
                        width: 40,
                        height: height * 0.7 * item.thisMonth / maxValue,
                      ),
                      Text("이번달", style: TextStyles.label),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${item.variationRate}%",
                    style:
                        TextStyles.title.copyWith(color: ColorStyles.primary),
                  ),
                  Text("지난달 대비")
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    ));
  }
}
