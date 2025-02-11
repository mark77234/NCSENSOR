import '../data/statistic_model.dart';
import 'article_model.dart';
import 'statistic_model.dart';

class NcsMetaData {
  final int version;
  final List<ArticleMeta> articles;
  final StatsMeta stats;

  NcsMetaData({
    required this.version,
    required this.articles,
    required this.stats,
  });

  factory NcsMetaData.fromJson(Map<String, dynamic> json) {
    return NcsMetaData(
      version: json['version'] as int,
      articles: (json['articles'] as List)
          .map((article) => ArticleMeta.fromJson(article))
          .toList(),
      stats: StatsMeta.fromJson(json['stats']),
    );
  }

  ArticleMeta? findArticleById(String id) {
    try {
      return articles.firstWhere((article) => article.id == id);
    } catch (e) {
      return null;
    }
  }

  StatMetaItem? findStatByData(StatisticData data) {
    try {
      switch (data.ui) {
        case StatisticUi.percent:
          return stats.percent.firstWhere((p) => p.type == data.type);
        case StatisticUi.card:
          return stats.card.firstWhere((c) => c.type == data.type);
        case StatisticUi.comparison:
          return stats.comparison.firstWhere((c) => c.type == data.type);
      }
    } catch (e) {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'articles': articles.map((article) => article.toJson()).toList(),
      'stats': stats.toJson(),
    };
  }
}
