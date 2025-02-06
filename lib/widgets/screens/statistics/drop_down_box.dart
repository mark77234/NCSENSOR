import 'package:NCSensor/constants/styles.dart';
import 'package:flutter/material.dart';

import '../../../models/ui/article_model.dart';
import '../../../storage/data/ui_storage.dart';

class DropDownBox extends StatefulWidget {
  const DropDownBox(
      {super.key, required this.setArticle, required this.selectedArticle});

  final Function setArticle;
  final ArticleMeta? selectedArticle;

  @override
  State<DropDownBox> createState() => _DropDownBoxState();
}

class _DropDownBoxState extends State<DropDownBox> {
  @override
  void initState() {
    super.initState();
    if (widget.selectedArticle == null) {
      final articles = UiStorage.data.articles;
      if (articles.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.setArticle(articles.first);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final articles = UiStorage.data.articles;

    return Container(
      width: 200,
      padding: EdgeInsets.all(4),
      decoration: ContainerStyles.tile.copyWith(color: ColorStyles.lightgrey),
      child: DropdownButton<ArticleMeta>(
        value: widget.selectedArticle,
        onChanged: (ArticleMeta? newValue) {
          if (newValue != null) widget.setArticle(newValue);
        },
        isExpanded: true,
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        underline: SizedBox(),
        isDense: true,
        borderRadius: RadiusStyles.common,
        items: articles.map((ArticleMeta article) {
          return DropdownMenuItem<ArticleMeta>(
            value: article,
            child: Center(
              child: Text(
                article.name,
                style: TextStyles.subtitle.copyWith(
                  color: widget.selectedArticle?.id == article.id
                      ? Colors.black
                      : ColorStyles.secondary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
