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

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'articles': articles.map((article) => article.toJson()).toList(),
      'stats': stats.toJson(),
    };
  }
}

class Article {
  final String id;
  final String name;
  final String? unit;
  final String content;
  final String icon;
  final Result? result;
  final List<Section>? sections;
  final List<Subtype>? subtypes;

  Article({
    required this.id,
    required this.name,
    this.unit,
    required this.content,
    required this.icon,
    this.result,
    this.sections,
    this.subtypes,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as String,
      name: json['name'] as String,
      unit: json['unit'],
      content: json['content'] as String,
      icon: json['icon'] as String,
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
      sections: json['sections'] != null
          ? (json['sections'] as List).map((e) => Section.fromJson(e)).toList()
          : null,
      subtypes: json['subtypes'] != null
          ? (json['subtypes'] as List).map((e) => Subtype.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'content': content,
      'icon': icon,
      'result': result?.toJson(),
      'sections': sections?.map((e) => e.toJson()).toList(),
      'subtypes': subtypes?.map((e) => e.toJson()).toList(),
    };
  }
}

class Subtype {
  final String id;
  final String name;
  final String? unit;
  final String content;
  final String icon;
  final Result result;
  final List<Section> sections;

  Subtype({
    required this.id,
    required this.name,
    this.unit,
    required this.content,
    required this.icon,
    required this.result,
    required this.sections,
  });

  factory Subtype.fromJson(Map<String, dynamic> json) {
    return Subtype(
      id: json['id'] as String,
      name: json['name'] as String,
      unit: json['unit'],
      content: json['content'] as String,
      icon: json['icon'] as String,
      result: Result.fromJson(json['result']),
      sections: (json['sections'] as List)
          .map((e) => Section.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'unit': unit,
      'content': content,
      'icon': icon,
      'result': result.toJson(),
      'sections': sections.map((e) => e.toJson()).toList(),
    };
  }
}

class Result {
  final String title;
  final num min;
  final num max;

  Result({
    required this.title,
    required this.min,
    required this.max,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      title: json['title'] as String,
      min: json['min'] as num,
      max: json['max'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'min': min,
      'max': max,
    };
  }
}

class Section {
  final int level;
  final String name;
  final ValueRange min;
  final ValueRange max;
  final String content;
  final String color;

  Section({
    required this.level,
    required this.name,
    required this.min,
    required this.max,
    required this.content,
    required this.color,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      level: json['level'] as int,
      name: json['name'] as String,
      min: ValueRange.fromJson(json['min']),
      max: ValueRange.fromJson(json['max']),
      content: json['content'] as String,
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'name': name,
      'min': min.toJson(),
      'max': max.toJson(),
      'content': content,
      'color': color,
    };
  }
}

class ValueRange {
  final num value;
  final bool isContained;

  ValueRange({
    required this.value,
    required this.isContained,
  });

  factory ValueRange.fromJson(Map<String, dynamic> json) {
    return ValueRange(
      value: json['value'] as num,
      isContained: json['is_contained'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'is_contained': isContained,
    };
  }
}

class Stats {
  final List<StatCard> cardStats;
  final List<StatPercent> percentStats;
  final List<StatComparison> comparisonStats;

  Stats({
    required this.cardStats,
    required this.percentStats,
    required this.comparisonStats,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      cardStats: (json['CARD'] as List)
          .map((e) => StatCard.fromJson(e))
          .toList(),
      percentStats: (json['PERCENT'] as List)
          .map((e) => StatPercent.fromJson(e))
          .toList(),
      comparisonStats: (json['COMPARISON'] as List)
          .map((e) => StatComparison.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CARD': cardStats.map((e) => e.toJson()).toList(),
      'PERCENT': percentStats.map((e) => e.toJson()).toList(),
      'COMPARISON': comparisonStats.map((e) => e.toJson()).toList(),
    };
  }
}

class StatCard {
  final String type;
  final String title;
  final String unit;
  final String icon;

  StatCard({
    required this.type,
    required this.title,
    required this.unit,
    required this.icon,
  });

  factory StatCard.fromJson(Map<String, dynamic> json) {
    return StatCard(
      type: json['type'] as String,
      title: json['title'] as String,
      unit: json['unit'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'unit': unit,
      'icon': icon,
    };
  }
}

class StatPercent {
  final String type;
  final String title;
  final String unit;
  final String icon;

  StatPercent({
    required this.type,
    required this.title,
    required this.unit,
    required this.icon,
  });

  factory StatPercent.fromJson(Map<String, dynamic> json) {
    return StatPercent(
      type: json['type'] as String,
      title: json['title'] as String,
      unit: json['unit'] as String,
      icon: json['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'unit': unit,
      'icon': icon,
    };
  }
}

class StatComparison {
  final String type;
  final String title;
  final ComparisonResult result;
  final ComparisonChart chart;

  StatComparison({
    required this.type,
    required this.title,
    required this.result,
    required this.chart,
  });

  factory StatComparison.fromJson(Map<String, dynamic> json) {
    return StatComparison(
      type: json['type'] as String,
      title: json['title'] as String,
      result: ComparisonResult.fromJson(json['result']),
      chart: ComparisonChart.fromJson(json['chart']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'result': result.toJson(),
      'chart': chart.toJson(),
    };
  }
}

class ComparisonResult {
  final String unit;
  final String content;

  ComparisonResult({
    required this.unit,
    required this.content,
  });

  factory ComparisonResult.fromJson(Map<String, dynamic> json) {
    return ComparisonResult(
      unit: json['unit'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit': unit,
      'content': content,
    };
  }
}

class ComparisonChart {
  final num min;
  final num max;
  final List<ChartBar> bar;

  ComparisonChart({
    required this.min,
    required this.max,
    required this.bar,
  });

  factory ComparisonChart.fromJson(Map<String, dynamic> json) {
    return ComparisonChart(
      min: json['min'] as num,
      max: json['max'] as num,
      bar: (json['bar'] as List)
          .map((e) => ChartBar.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
      'bar': bar.map((e) => e.toJson()).toList(),
    };
  }
}

class ChartBar {
  final String type;
  final String name;
  final String color;

  ChartBar({
    required this.type,
    required this.name,
    required this.color,
  });

  factory ChartBar.fromJson(Map<String, dynamic> json) {
    return ChartBar(
      type: json['type'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'color': color,
    };
  }
}