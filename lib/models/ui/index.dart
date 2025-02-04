
import 'article_model.dart';
import 'statistic_model.dart';

class UiData {
  final int version;
  final List<Article> articles;
  final Stats stats;

  UiData({
    required this.version,
    required this.articles,
    required this.stats,
  });

  factory UiData.fromJson(Map<String, dynamic> json) {
    return UiData(
      version: json['version'] as int,
      articles: (json['articles'] as List)
          .map((article) => Article.fromJson(article))
          .toList(),
      stats: Stats.fromJson(json['stats']),
    );
  }

  Article? findArticleById(String id) {
    try{
      return articles.firstWhere((article) => article.id == id);
    }catch(e){
      return null;
    }
  }

  // Stat? findStatByData(StatisticData data) {
  //   try {
  //     switch (data.ui) {
  //       case StatisticUi.percent:
  //         return stats.percent.firstWhere((p) => p.type == data.type);
  //       case StatisticUi.card:
  //         return stats.card.firstWhere((c) => c.type == data.type);
  //       case StatisticUi.comparison:
  //         return stats.comparison.firstWhere((c) => c.type == data.type);
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

}