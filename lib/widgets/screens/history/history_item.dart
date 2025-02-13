import 'package:NCSensor/models/data/history_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/styles.dart';
import '../../../models/meta/article_model.dart';
import '../../common/icon_widget.dart';

class HistoryItem extends StatelessWidget {
  final HistoryData data;
  final ArticleMeta article;

  const HistoryItem({
    super.key,
    required this.data,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    Section? section = article.findSectionForValue(data.value);
    return Container(
      decoration: ContainerStyles.card,
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.only(right: 4),
      child: ListTile(
        leading: _buildHistoryIcon(article.icon),
        title: Text(article.name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        subtitle: Text(
          DateFormat('HH:mm').format(data.datetime),
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${data.value}${article.unit}',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 6),
            Text(section?.name ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: section?.color,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryIcon(String assetName) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: IconWidget(icon: assetName),
    );
  }
}
