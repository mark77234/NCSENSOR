import 'dart:ui';

import '../../utils/util.dart';

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
      sections:
      (json['sections'] as List).map((e) => Section.fromJson(e)).toList(),
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
  final Color color;

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
      color: colorFromHex(json['color']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'name': name,
      'min': min.toJson(),
      'max': max.toJson(),
      'content': content,
      'color': colorToHex(color),
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