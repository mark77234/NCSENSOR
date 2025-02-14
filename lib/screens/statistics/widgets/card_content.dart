import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/models/data/statistic_model.dart';
import 'package:NCSensor/models/meta/statistic_model.dart';
import 'package:NCSensor/widgets/icon_widget.dart';
import 'package:flutter/material.dart';

import '../../../widgets/my_card.dart';

class CardContent extends StatelessWidget {
  final CardData data;
  final StatCardMeta meta;

  const CardContent({
    super.key,
    required this.data,
    required this.meta,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: IconWidget(icon: meta.icon),
        ),
        title: Text(
          meta.title,
          style: TextStyles.label,
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(data.value.toString(), style: TextStyles.title),
            SizedBox(width: 8),
            Text(meta.unit.toString(),
                style: TextStyles.label.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
