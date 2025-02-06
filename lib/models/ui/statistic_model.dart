class StatsMeta {
  final List<StatCard> card;
  final List<StatPercent> percent;
  final List<StatComparison> comparison;

  StatsMeta({
    required this.card,
    required this.percent,
    required this.comparison,
  });

  factory StatsMeta.fromJson(Map<String, dynamic> json) {
    return StatsMeta(
      card: (json['CARD'] as List).map((e) => StatCard.fromJson(e)).toList(),
      percent: (json['PERCENT'] as List)
          .map((e) => StatPercent.fromJson(e))
          .toList(),
      comparison: (json['COMPARISON'] as List)
          .map((e) => StatComparison.fromJson(e))
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

class StatCard extends StatMetaItem {
  final String unit;
  final String icon;

  StatCard({
    required super.type,
    required super.title,
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

class StatPercent extends StatMetaItem {
  final num? min;
  final num? max;
  final String? unit;
  final String? icon;

  StatPercent({
    required super.type,
    required super.title,
    required this.unit,
    required this.icon,
    this.min,
    this.max,
  });

  factory StatPercent.fromJson(Map<String, dynamic> json) {
    return StatPercent(
      type: json['type'] as String,
      title: json['title'] as String,
      unit: json['unit'] != null ? json['unit'] as String : null,
      icon: json['icon'] != null ? json['icon'] as String : null,
      min: json['min'] != null ? json['min'] as num : null,
      max: json['max'] != null ? json['max'] as num : null,
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
    };
  }
}

class StatComparison extends StatMetaItem {
  final String? unit;
  final num? min;
  final num? max;

  StatComparison({
    required super.type,
    required super.title,
    this.unit,
    this.min,
    this.max,
  });

  factory StatComparison.fromJson(Map<String, dynamic> json) {
    return StatComparison(
      type: json['type'] as String,
      title: json['title'] as String,
      unit: json['unit'] != null ? json['unit'] as String : null,
      min: json['min'] != null ? json['min'] as num : null,
      max: json['max'] != null ? json['max'] as num : null,
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
