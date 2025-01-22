import 'package:flutter/material.dart';

import '../../constants/styles.dart';
import '../../models/statistic_data_model.dart';
import 'my_card.dart';

class CompareGraphCard extends StatelessWidget {
  const CompareGraphCard({super.key, required this.data, required this.height});

  final ComparisonChart data;
  final double height;

  @override
  Widget build(BuildContext context) {
    double diff = data.max - data.min;
    return MyCard(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 8),
        Text(
          data.title,
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
                children: data.bars.map((ComparisonBar item) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(item.value.toString(), style: TextStyles.title),
                      Container(
                        color: item.color.withAlpha(100),
                        width: 40,
                        height: height * 0.6 * item.value / diff,
                      ),
                      Text(item.name, style: TextStyles.label),
                    ],
                  );
                }).toList(),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${data.comment.value}${data.comment.unit}",
                    style: TextStyles.title.copyWith(color: data.comment.color),
                  ),
                  Text(data.comment.content)
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
