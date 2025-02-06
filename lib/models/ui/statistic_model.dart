import '../data/statistic_model.dart';

class StatsMeta {
  final List<StatCardMeta> card;
  final List<StatPercentMeta> percent;
  final List<StatCompareMeta> comparison;

  StatsMeta({
    required this.card,
    required this.percent,
    required this.comparison,
  });

  StatMetaItem? findMetaByData(StatisticData data) {
    try {
      switch (data.ui) {
        case StatisticUi.card:
          return card.firstWhere(
            (item) => item.type == data.type,
            orElse: () =>
                throw Exception('Card meta not found for type: ${data.type}'),
          );
        case StatisticUi.percent:
          return percent.firstWhere(
            (item) => item.type == data.type,
            orElse: () => throw Exception(
                'Percent meta not found for type: ${data.type}'),
          );
        case StatisticUi.comparison:
          return comparison.firstWhere(
            (item) => item.type == data.type,
            orElse: () => throw Exception(
                'Comparison meta not found for type: ${data.type}'),
          );
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  factory StatsMeta.fromJson(Map<String, dynamic> json) {
    return StatsMeta(
      card:
          (json['CARD'] as List).map((e) => StatCardMeta.fromJson(e)).toList(),
      percent: (json['PERCENT'] as List)
          .map((e) => StatPercentMeta.fromJson(e))
          .toList(),
      comparison: (json['COMPARISON'] as List)
          .map((e) => StatCompareMeta.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CARD': card.map((e) => e.toJson()).toList(),
      'PERCENT': percent.map((e) => e.toJson()).toList(),
      'COMPARISON': comparison.map((e) => e.toJson()).toList(),
    };
  }
}

abstract class StatMetaItem {
  final String type;
  final String title;

  StatMetaItem({
    required this.type,
    required this.title,
  });

  Map<String, dynamic> toJson();
}

class StatCardMeta extends StatMetaItem {
  final String unit;
  final String icon;

  StatCardMeta({
    required super.type,
    required super.title,
    required this.unit,
    required this.icon,
  });

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
    };
  }
}

class StatPercentMeta extends StatMetaItem {
  // final num min;
  // final num max;
  final String? unit;
  final String? icon;

  StatPercentMeta({
    required super.type,
    required super.title,
    this.unit,
    this.icon,
    // required this.min,
    // required this.max,
  });

  factory StatPercentMeta.fromJson(Map<String, dynamic> json) {
    return StatPercentMeta(
      type: json['type'] as String,
      title: json['title'] as String,
      unit: json['unit'] != null ? json['unit'] as String : null,
      icon: json['icon'] != null ? json['icon'] as String : null,
      // min: json['min'] as num,
      // max: json['max'] as num,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'unit': unit,
      'icon': icon,
      // 'min': min,
      // 'max': max,
    };
  }
}

class StatCompareMeta extends StatMetaItem {
  final String? unit;
  final num min;
  final num max;

  StatCompareMeta({
    required super.type,
    required super.title,
    this.unit,
    required this.min,
    required this.max,
  });

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
    };
  }
}
