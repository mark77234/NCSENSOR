class BodyResultData {
  final int level;
  final String name;
  final String content;
  final String color;

  BodyResultData({
    required this.level,
    required this.name,
    required this.content,
    required this.color,
  });

  factory BodyResultData.fromJson(Map<String, dynamic> json) {
    return BodyResultData(
      level: json['section']['level'].toInt(),
      name: json['section']['name'],
      content: json['section']['content'],
      color: json['section']['color'],
    );
  }
}
