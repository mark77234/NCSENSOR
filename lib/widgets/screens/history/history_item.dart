import 'package:NCSensor/models/data/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../models/ui/article_model.dart';

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
    return ListTile(
      leading: _buildHistoryIcon(article.icon),
      title: Text(article.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${data.value} ${article?.unit ?? ''}'),
          Text(section?.name ?? '', style: TextStyle(color: section?.color)),
        ],
      ),
      trailing: Text(
        DateFormat('HH:mm').format(data.datetime),
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _buildHistoryIcon(String assetName) {
    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: SvgPicture.asset(
        "assets/$assetName.svg",
        width: 40,
        height: 40,
      ),
    );
  }
}
