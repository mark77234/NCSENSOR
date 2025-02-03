import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../constants/styles.dart';
import '../../../models/history_model.dart';

class HistoryItem extends StatelessWidget {
  final HistoryData record;

  const HistoryItem({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerStyles.card,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: _buildHistoryIcon(record.title),
        title: Text(
          record.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat('HH:mm').format(record.datetime),
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${record.result.value} ${record.result.unit}",
              style: TextStyle(
                fontSize: 14,
                color: ColorStyles.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              record.result.content,
              style: TextStyle(
                fontSize: 14,
                color: ColorStyles.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryIcon(String title) {
    String assetName;

    switch (title) {
      case "음주":
        assetName = "drinking";
        break;
      case "입냄새":
        assetName = "mouth";
        break;
      case "겨드랑이냄새":
        assetName = "armpit";
        break;
      case "발냄새":
        assetName = "foot";
        break;
      default:
        assetName = "measure";
    }

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
