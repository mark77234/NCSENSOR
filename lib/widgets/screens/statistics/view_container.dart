import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/data/statistic_model.dart';
import '../../../models/ui/article_model.dart';
import '../../../services/api_service.dart';
import '../../../utils/api_hook.dart';
import '../../common/empty_display_box.dart';
import '../../common/my_card.dart';

class ViewContainer extends StatefulWidget {
  const ViewContainer({super.key, required this.selectedArticle});

  final ArticleMeta selectedArticle;

  @override
  State<ViewContainer> createState() => _ViewContainerState();
}

class _ViewContainerState extends State<ViewContainer> {
  late final ApiHook<List<StatisticData>> statisticApiHook;

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
    final ApiState(:isLoading, :data, :error) = statisticApiHook.state;
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return EmptyDisplayBox(
        icon: Icons.error,
        text: "통계을 불러오는 중 오류가 발생했습니다.",
      );
    }
    if (data?.isEmpty ?? true) {
      return EmptyDisplayBox(
        icon: Icons.history,
        text: "통계가 없습니다.",
      );
    }

    return Column(
      children: [
        ...data!.map((data) => _buildViewContent(data)),
      ],
    );
  }

  Widget _buildViewContent(StatisticData data) {
    switch (data.ui) {
      case StatisticUi.card:
        return _buildCardContent(data as CardData);
      case StatisticUi.percent:
        return _buildPercentContent(data as PercentData);
      case StatisticUi.comparison:
        return _buildComparisonContent(data as ComparisonData);
    }
    return SizedBox();
  }

  Widget _buildCardContent(CardData card) {
    return MyCard(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(right: 2.0),
        ),
      ),
    );
  }

  Widget _buildPercentContent(PercentData chart) {
    return MyCard(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            SizedBox(height: 8),
            Stack(children: [
              SvgPicture.asset(
                "assets/icons/customGraph.svg",
                width: 96,
                height: 200,
              ),
            ]),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonContent(ComparisonData data) {
    return Column(
      children: data.charts.map((chart) {
        return MyCard(
          child: ListTile(
            title: Text(chart.type),
            subtitle:
                Text('지난달: ${chart.lastMonth}, 이번달: ${chart.currentMonth}'),
          ),
        );
      }).toList(),
    );
  }
}
