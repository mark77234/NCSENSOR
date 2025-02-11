import 'package:NCSensor/widgets/common/icon_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../../../models/data/statistic_model.dart';
import '../../../models/meta/article_model.dart';
import '../../../models/meta/statistic_model.dart';
import '../../../services/api_service.dart';
import '../../../storage/data/meta_storage.dart';
import '../../../utils/api_hook.dart';
import '../../common/api_state_builder.dart';
import '../../common/empty_display_box.dart';
import '../../common/my_card.dart';
import 'compare_graph_card.dart';

class ViewContainer extends StatefulWidget {
  const ViewContainer({super.key, required this.selectedArticle});

  final ArticleMeta selectedArticle;

  @override
  State<ViewContainer> createState() => _ViewContainerState();
}

class _ViewContainerState extends State<ViewContainer> {
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
  void didUpdateWidget(covariant ViewContainer oldWidget) {
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
        return _buildCardContent(data as CardData, statMeta as StatCardMeta);
      case StatisticUi.percent:
        return _buildPercentContent(
            data as PercentData, statMeta as StatPercentMeta);
      case StatisticUi.comparison:
        return CompareGraphCard(
          data: data as ComparisonData,
          meta: statMeta as StatCompareMeta,
        );
    }
  }

  Widget _buildCardContent(CardData card, StatCardMeta meta) {
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
            Text(card.value.toString(), style: TextStyles.title),
            SizedBox(width: 8),
            Text(meta.unit.toString(),
                style: TextStyles.label.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildPercentContent(PercentData data, StatPercentMeta meta) {
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
              // SvgPicture.asset(
              //   "assets/icons/customGraph.svg",
              //   width: 96,
              //   height: 200,
              // ),
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
