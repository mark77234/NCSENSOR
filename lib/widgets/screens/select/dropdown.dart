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
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorStyles.darkgrey,
            ),
          ),
        ),
        Container(
          width: SizeStyles.getMediaWidth(context, 0.8),
          decoration:
              ContainerStyles.tile.copyWith(color: ColorStyles.lightgrey),
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
                  size: 20,
                  color: ColorStyles.primary,
                ),
              ),
              dropdownColor: ColorStyles.background,
              borderRadius: RadiusStyles.common,
              menuMaxHeight: 400,
              itemHeight: 80,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
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
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              article.content,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    article.content,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
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
