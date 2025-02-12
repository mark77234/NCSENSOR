import 'package:NCSensor/widgets/screens/statistics/percent_content.dart';
import 'package:flutter/material.dart';

import '../../../models/data/statistic_model.dart';
import '../../../models/meta/article_model.dart';
import '../../../models/meta/statistic_model.dart';
import '../../../services/api_service.dart';
import '../../../storage/data/meta_storage.dart';
import '../../../utils/api_hook.dart';
import '../../common/api_state_builder.dart';
import '../../common/empty_display_box.dart';
import 'card_content.dart';
import 'compare_content.dart';

class StatsList extends StatefulWidget {
  const StatsList({super.key, required this.selectedArticle});

  final ArticleMeta selectedArticle;

  @override
  State<StatsList> createState() => _StatsListState();
}

class _StatsListState extends State<StatsList> {
  late final ApiHook<List<StatisticData>> statisticApiHook;
  late final StatsMeta statsMeta;

  @override
  void initState() {
    super.initState();
    statisticApiHook = ApiHook(
      apiCall: (params) => ApiService.getStatisticData(
        articleId: params['articleId'],
      ),
      params: {
        'articleId': widget.selectedArticle.id,
      },
    );
    statisticApiHook.addListener(() {
      setState(() {});
    });
    statsMeta = UiStorage.data.stats;
  }

  @override
  void didUpdateWidget(covariant StatsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    statisticApiHook.updateParams({
      'articleId': widget.selectedArticle.id,
    });
  }

  @override
  void dispose() {
    statisticApiHook.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ApiStateBuilder(
      apiState: statisticApiHook.state,
      title: "통계",
      icon: Icons.analytics_outlined,
      builder: (context, data) {
        return Column(
          children: [
            ...data!.map((data) => _buildViewContent(data)),
          ],
        );
      },
    );
  }

  Widget _buildViewContent(StatisticData data) {
    StatMetaItem? statMeta = statsMeta.findMetaByData(data);
    if (statMeta == null) {
      return EmptyDisplayBox(
        icon: Icons.error,
        text: "통계 메타 정보를 찾을 수 없습니다.",
      );
    }
    switch (data.ui) {
      case StatisticUi.card:
        return CardContent(
          data: data as CardData,
          meta: statMeta as StatCardMeta,
        );
      case StatisticUi.percent:
        return PercentContent(
          data: data as PercentData,
          meta: statMeta as StatPercentMeta,
        );
      case StatisticUi.comparison:
        return CompareContent(
          data: data as ComparisonData,
          meta: statMeta as StatCompareMeta,
        );
    }
  }
}
