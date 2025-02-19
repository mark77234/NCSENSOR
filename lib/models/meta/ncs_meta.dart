import '../data/statistic_model.dart';
import 'article_model.dart';
import 'statistic_model.dart';

class NcsMetaData {
  final int version;
  final List<ArticleMeta> articles;
  final List<StatsMeta> stats;

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
      stats: (json['stats'] as List)
          .map((stat) => StatsMeta.fromJson(stat))
          .toList(),
    );
  }

  StatsMeta? findStatByData(StatisticData data) {
    try {
      return stats
          .firstWhere((stat) => stat.type == data.type && stat.ui == data.ui);
    } catch (e) {
      return null;
    }
  }
  
  ArticleMeta? findArticleById(String id) {
    try {
      return articles.firstWhere((article) => article.id == id);
    } catch (e) {
      return null;
    }
  }



  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'articles': articles.map((article) => article.toJson()).toList(),
      'stats': stats.map((stat) => stat.toJson()).toList(),
    };
  }
}
