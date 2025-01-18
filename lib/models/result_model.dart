import 'dart:ui';

import '../utils/util.dart';

class BodyResultData {
  final String title;
  final String comment;
  final Chart chart;
  final Level level;

  BodyResultData({
    required this.title,
    required this.comment,
    required this.chart,
    required this.level,
  });

  factory BodyResultData.fromJson(Map<String, dynamic> json) {
    return BodyResultData(
      title: json['title'],
      comment: json['comment'],
      chart: Chart.fromJson(json['chart']),
      level: Level.fromJson(json['level']),
    );
  }
}

class Chart {
  final int min;
  final int max;
  final Result result;

  Chart({
    required this.min,
    required this.max,
    required this.result,
  });

  factory Chart.fromJson(Map<String, dynamic> json) {
    return Chart(
      min: json['min'],
      max: json['max'],
      result: Result.fromJson(json['result']),
    );
  }
}

class Result {
  final String unit;
  final int value;

  Result({
    required this.unit,
    required this.value,
  });

  factory Result.fromJson(Map<String, dynamic> json){
    return Result(
      unit: json['unit'],
      value: json['value'],
    );
  }
}

class Level {
  final String title;
  final int value;
  final List<Section> sections;

  Level({
    required this.title,
    required this.value,
    required this.sections,
  });

  factory Level.fromJson(Map<String, dynamic> json){
    return Level(
      title: json['title'],
      value: json['value'],
      sections: (json['sections'] as List)
          .map((e) => Section.fromJson(e))
          .toList(),
    );
  }
}

class Section {
  final int level;
  final String name;
  final String content;
  final Color color;

  Section({
    required this.level,
    required this.name,
    required this.content,
    required this.color,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      level: json['level'],
      name: json['name'],
      content: json['content'],
      color: colorFromHex(json['color']),
    );
  }
}

// class BodyResultData {
//   final int level;
//   final String name;
//   final String content;
//   final Color color;
//
//   BodyResultData({
//     required this.level,
//     required this.name,
//     required this.content,
//     required this.color,
//   });
//
//   factory BodyResultData.fromJson(Map<String, dynamic> json) {
//     return BodyResultData(
//       level: json['level'],
//       name: json['name'],
//       content: json['content'],
//       color: colorFromHex(json['color']),
//     );
//   }
// }
