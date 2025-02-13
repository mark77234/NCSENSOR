import 'package:NCSensor/widgets/common/icon_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../../../models/meta/article_model.dart';

class Dropdown extends StatelessWidget {
  final List<ArticleMeta> articles;
  final String selectedItem;
  final Function(String, String) onChanged;

  const Dropdown({
    super.key,
    required this.articles,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12.0),
          child: Text(
            '측정 항목 선택',
            style: TextStyle(
              fontSize: 20,
              color: ColorStyles.darkgrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: SizeStyles.getMediaWidth(context, 0.8),
          decoration: ContainerStyles.card.copyWith(
            borderRadius: RadiusStyles.largeRadius,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedItem.isEmpty ? articles.first.name : selectedItem,
              onChanged: (newValue) {
                final selectedArticle = articles.firstWhere(
                  (article) => article.name == newValue,
                );
                onChanged(newValue!, selectedArticle.id);
              },
              items: articles
                  .map((article) => _buildDropdownItem(article))
                  .toList(),
              isExpanded: true,
              icon: const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(
                  Icons.arrow_drop_down,
                  size: 25,
                ),
              ),
              dropdownColor: Colors.white,
              borderRadius: RadiusStyles.largeRadius,
              menuMaxHeight: 400,
              itemHeight: 80,
              style: MeasureTextStyles.main,
              selectedItemBuilder: (BuildContext context) {
                return articles.map<Widget>((ArticleMeta article) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        IconWidget(icon: article.icon),
                        const SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.name,
                              style: MeasureTextStyles.main,
                            ),
                            const SizedBox(height: 10),
                            Text(article.content, style: MeasureTextStyles.sub),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ],
    );
  }

  // 드롭다운 아이템 빌드
  DropdownMenuItem<String> _buildDropdownItem(ArticleMeta article) {
    return DropdownMenuItem<String>(
      value: article.name,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            IconWidget(icon: article.icon),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.name,
                    style: MeasureTextStyles.main,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    article.content,
                    style: MeasureTextStyles.sub,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
