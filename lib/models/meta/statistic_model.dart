import '../data/statistic_model.dart';

abstract class StatsMeta {
  final String type;
  final String title;
  final StatisticUi ui;

  StatsMeta({required this.type, required this.title, required this.ui});

  factory StatsMeta.fromJson(Map<String, dynamic> json) {
    String ui = json['ui'] as String;
    switch (ui) {
      case 'CARD':
        return StatCardMeta.fromJson(json);
      case 'PERCENT':
        return StatPercentMeta.fromJson(json);
      case 'COMPARISON':
        return StatCompareMeta.fromJson(json);
      default:
        throw Exception('Unknown StatsMeta type: $ui');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'ui': ui,
    };
  }
}

class StatCardMeta extends StatsMeta {
  final String unit;
  final String icon;

  StatCardMeta({
    required super.type,
    required super.title,
    required this.unit,
    required this.icon,
  }) : super(ui: StatisticUi.card);

  factory StatCardMeta.fromJson(Map<String, dynamic> json) {
    return StatCardMeta(
      type: json['type'] as String,
      title: json['title'] as String,
      unit: json['unit'] as String,
      icon: json['icon'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'unit': unit,
      'icon': icon,
      'ui': 'CARD',
    };
  }
}

class StatPercentMeta extends StatsMeta {
  final num min;
  final num max;
  final String? unit;
  final String icon;

  StatPercentMeta({
    required super.type,
    required super.title,
    this.unit,
    required this.icon,
    required this.min,
    required this.max,
  }) : super(ui: StatisticUi.percent);

  factory StatPercentMeta.fromJson(Map<String, dynamic> json) {
    return StatPercentMeta(
      type: json['type'] as String,
      title: json['title'] as String,
      unit: json['unit'] != null ? json['unit'] as String : null,
      icon: json['icon'] as String,
      min: json['min'] as num,
      max: json['max'] as num,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'unit': unit,
      'icon': icon,
      'min': min,
      'max': max,
      'ui': 'PERCENT',
    };
  }
}

class StatCompareMeta extends StatsMeta {
  final String? unit;
  final num min;
  final num max;

  StatCompareMeta({
    required super.type,
    required super.title,
    this.unit,
    required this.min,
    required this.max,
  }) : super(ui: StatisticUi.comparison);

  factory StatCompareMeta.fromJson(Map<String, dynamic> json) {
    return StatCompareMeta(
      type: json['type'] as String,
      title: json['title'] as String,
      unit: json['unit'] != null ? json['unit'] as String : null,
      min: json['min'] as num,
      max: json['max'] as num,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'unit': unit,
      'min': min,
      'max': max,
      'ui': 'COMPARISON',
    };
  }
}
