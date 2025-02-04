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
      cardStats:
      (json['CARD'] as List).map((e) => StatCard.fromJson(e)).toList(),
      percentStats: (json['PERCENT'] as List)
          .map((e) => StatPercent.fromJson(e))
          .toList(),
      comparisonStats: (json['COMPARISON'] as List)
          .map((e) => StatComparison.fromJson(e))
          .toList(),
    );
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
  final ComparisonResult? result;
  final ComparisonChart? chart;

  StatComparison({
    required this.type,
    required this.title,
    this.result,
    this.chart,
  });

  factory StatComparison.fromJson(Map<String, dynamic> json) {
    return StatComparison(
      type: json['type'] as String,
      title: json['title'] as String,
      result: json['result'] != null
          ? ComparisonResult.fromJson(json['result'])
          : null, // null 체크 추가
      chart: json['chart'] != null
          ? ComparisonChart.fromJson(json['chart'])
          : null, // null 체크 추가
    );
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
      bar: (json['bar'] as List).map((e) => ChartBar.fromJson(e)).toList(),
    );
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
}
