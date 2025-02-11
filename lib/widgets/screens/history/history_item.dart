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
      child: ListTile(
        leading: _buildHistoryIcon(article.icon),
        title: Text(article.name,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Text('${data.value} ${article?.unit ?? ''}'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('HH:mm').format(data.datetime),
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 4),
            Text(section?.name ?? '',
                style: TextStyle(
                    color: section?.color, fontWeight: FontWeight.bold)),
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
