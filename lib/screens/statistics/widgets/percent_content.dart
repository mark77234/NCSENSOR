import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/models/data/statistic_model.dart';
import 'package:NCSensor/models/meta/statistic_model.dart';
import 'package:NCSensor/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/my_card.dart';

class PercentContent extends StatelessWidget {
  final PercentData data;
  final StatPercentMeta meta;

  const PercentContent({
    super.key,
    required this.data,
    required this.meta,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Text(
              meta.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Stack(children: [
              Positioned(
                left: 24,
                bottom: 20,
                child: Container(
                  color: Color(0xFF57D655),
                  width: 40,
                  height: 145 * data.value / 1,
                ),
              ),
              IconWidget(icon: meta.icon),
            ]),
            Text(
              "${data.value}${meta.unit}",
              style: TextStyles.title,
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
