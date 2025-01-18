class ArticleData {
  final List<Article> articles;

  ArticleData({
    required this.articles,
  });

  factory ArticleData.fromJson(Map<String, dynamic> json) {
    return ArticleData(
      articles: (json['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList(),
    );
  }
}

class Article {
  final String id;
  final String name;
  final List<Subtype>? subtypes;

  Article({
    required this.id,
    required this.name,
    this.subtypes,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      name: json['name'],
      subtypes: json['subtypes'] != null
          ? (json['subtypes'] as List)
          .map((e) => Subtype.fromJson(e))
          .toList()
          : null,
    );
  }
}

class Subtype {
  final String id;
  final String name;

  Subtype({
    required this.id,
    required this.name,
  });

  factory Subtype.fromJson(Map<String, dynamic> json) {
    return Subtype(
      id: json['id'],
      name: json['name'],
    );
  }
}