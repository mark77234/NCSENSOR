import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../../../models/data/result_model.dart';
import '../../../models/meta/article_model.dart';

class ResultCard extends StatelessWidget {
  final ArticleMeta article;
  final BodyResultData result;

  const ResultCard({super.key, required this.article, required this.result});

  int get stage {
    for (int i = 0; i < article.sections.length; i++) {
      final section = article.sections[i];
      final min = section.min.value;
      final max = section.max.value;
      final isMinContained = section.min.isContained;
      final isMaxContained = section.max.isContained;
      final measuredValue = result.value;

      if ((isMinContained ? measuredValue >= min : measuredValue > min) &&
          (isMaxContained ? measuredValue <= max : measuredValue < max)) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    var sections = article.sections;
    return Container(
      decoration: ContainerStyles.card,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('현재 상태',
                  style: MeasureTextStyles.main.copyWith(
                    fontSize: 20,
                  )),
              Row(
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: sections[stage].color,
                  ),
                  const SizedBox(width: 10),
                  Text(sections[stage].name,
                      style: MeasureTextStyles.main.copyWith(
                        fontSize: 18,
                        color: sections[stage].color,
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${result.value}",
                  style: MeasureTextStyles.main.copyWith(
                    fontSize: 48,
                  )),
              const SizedBox(width: 8),
              Text(article.unit ?? '',
                  style: MeasureTextStyles.sub.copyWith(
                    fontSize: 24,
                    color: ColorStyles.darkgrey,
                  )),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: result.value / article.result.max,
            backgroundColor: const Color(0xFFF3F4F6),
            valueColor: AlwaysStoppedAnimation<Color>(sections[stage].color),
          ),
          const SizedBox(height: 10),
          Text(
            result.comment,
            style: MeasureTextStyles.sub
                .copyWith(fontSize: 16, color: ColorStyles.darkgrey),
          ),
        ],
      ),
    );
  }
}
