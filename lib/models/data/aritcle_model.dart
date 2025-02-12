class ArticleData {
  final List<Article> articles;

  ArticleData({
    required this.articles,
  });

  factory ArticleData.fromJson(Map<String, dynamic> json) {
    return ArticleData(
      articles:
          (json['articles'] as List).map((e) => Article.fromJson(e)).toList(),
    );
  }
}

class Article {
  final String id;
  final String name;

  Article({
    required this.id,
    required this.name,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      name: json['name'],
    );
  }
}
