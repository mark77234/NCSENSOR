import 'package:flutter/material.dart';

import '../../models/data/measure_model.dart';
import '../../models/data/statistic_model.dart';
import '../../models/meta/article_model.dart';
import '../../widgets/common/empty_display_box.dart';
import '../../widgets/common/my_header.dart';
import '../../widgets/screens/statistics/drop_down_box.dart';
import '../../widgets/screens/statistics/stats_list.dart';

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
              EmptyDisplayBox(
                icon: Icons.analytics_outlined,
                text: "조회할 통계가 없습니다.",
              )
            else
              StatsList(selectedArticle: selectedArticle!),
          ],
        ),
      ),
    );
  }
}
