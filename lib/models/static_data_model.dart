import 'dart:ui';

import '../utils/util.dart';

enum StaticViewType {
  percent,
  card,
  comparison,
}

abstract class StatisticData {
  final StaticViewType type;

  StatisticData({
    required this.type,
  });

  factory StatisticData.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case "PERCENT":
        return PercentData.fromJson(json);
      case "CARD":
        return CardData.fromJson(json);
      case "COMPARISION":
        return ComparisonData.fromJson(json);
      default:
        throw Exception("Invalid type");
    }
  }
}

class PercentData extends StatisticData {
  final String title;
  final double min;
  final double max;
  final double value;
  final String unit;

  PercentData({
    required this.title,
    required this.min,
    required this.max,
    required this.value,
    required this.unit,
  }) : super(type: StaticViewType.percent);

  factory PercentData.fromJson(Map<String, dynamic> json) {
    return PercentData(
      title: json['title'],
      min: json['chart']['min'].toDouble(),
      max: json['chart']['max'].toDouble(),
      value: json['chart']['value'].toDouble(),
      unit: json['chart']['unit'],
    );
  }
}

class CardData extends StatisticData {
  final String title;
  final double value;
  final String unit;
  final String icon;

  CardData({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
  }) : super(type: StaticViewType.card);

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      title: json['card']['title'],
      value: json['card']['body']['value'].toDouble(),
      unit: json['card']['body']['unit'],
      icon: json['card']['icon'],
    );
  }
}

class ComparisonData extends StatisticData {
  final List<ComparisonChart> charts;

  ComparisonData({
    required this.charts,
  }) : super(type: StaticViewType.comparison);

  factory ComparisonData.fromJson(Map<String, dynamic> json) {
    return ComparisonData(
      charts: (json['charts'] as List)
          .map((e) => ComparisonChart.fromJson(e))
          .toList(),
    );
  }
}

class ComparisonChart {
  final String title;
  final List<ComparisonBar> bars;
  final double min;
  final double max;
  final ComparisonComment comment;

  ComparisonChart({
    required this.title,
    required this.bars,
    required this.min,
    required this.max,
    required this.comment,
  });

  factory ComparisonChart.fromJson(Map<String, dynamic> json) {
    return ComparisonChart(
      title: json['title'],
      bars:
      (json['bar'] as List).map((e) => ComparisonBar.fromJson(e)).toList(),
      min: json['min'].toDouble(),
      max: json['max'].toDouble(),
      comment: ComparisonComment.fromJson(json['comment']),
    );
  }
}

class ComparisonBar {
  final String name;
  final double value;
  final Color color;

  ComparisonBar({
    required this.name,
    required this.value,
    required this.color,
  });

  factory ComparisonBar.fromJson(Map<String, dynamic> json) {
    //# 형태로 color값이옴
    return ComparisonBar(
        name: json['name'],
        value: json['value'].toDouble(),
        color: colorFromHex(json['color']));
  }
}

class ComparisonComment {
  final double value;
  final String unit;
  final String content;
  final Color color;

  ComparisonComment({
    required this.value,
    required this.unit,
    required this.content,
    required this.color,
  });

  factory ComparisonComment.fromJson(Map<String, dynamic> json) {
    return ComparisonComment(
      value: json['value'].toDouble(),
      unit: json['unit'],
      content: json['content'],
      color: colorFromHex(json['color']),
    );
  }
}