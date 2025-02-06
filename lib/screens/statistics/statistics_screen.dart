import 'package:flutter/material.dart';

import '../../models/data/measure_model.dart';
import '../../models/data/statistic_model.dart';
import '../../models/ui/article_model.dart';
import '../../widgets/common/my_header.dart';
import '../../widgets/screens/statistics/drop_down_box.dart';
import '../../widgets/screens/statistics/view_container.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  ArticleMeta? selectedArticle;
  List<MeasureLabel> measureLabels = [];
  List<StatisticData>? statisticData;

  setArticle(ArticleMeta article) {
    setState(() {
      selectedArticle = article;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyHeader(title: "통계"),
            DropDownBox(
              setArticle: setArticle,
              selectedArticle: selectedArticle,
            ),
            SizedBox(height: 16),
            if (selectedArticle == null)
              _buildEmptyState()
            else
              ViewContainer(selectedArticle: selectedArticle!),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 48,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "조회할 통계가 없습니다.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
