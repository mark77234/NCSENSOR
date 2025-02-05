enum StatisticUi {
  percent,
  card,
  comparison,
}

abstract class StatisticData {
  final StatisticUi ui;
  final String type;

  StatisticData({
    required this.ui,
    required this.type,
  });

  factory StatisticData.fromJson(Map<String, dynamic> json) {
    switch (json['ui']) {
      case "PERCENT":
        return PercentData.fromJson(json);
      case "CARD":
        return CardData.fromJson(json);
      case "COMPARISON":
        return ComparisonData.fromJson(json);
      default:
        throw Exception("Invalid ui type");
    }
  }
}

class PercentData extends StatisticData {
  final double value;

  PercentData({
    required this.value,
    required super.type,
  }) : super(ui: StatisticUi.percent);

  factory PercentData.fromJson(Map<String, dynamic> json) {
    return PercentData(
      value: json['value'].toDouble(),
      type: json['type'],
    );
  }
}

class CardData extends StatisticData {
  final double value;

  CardData({
    required this.value,
    required super.type,
  }) : super(ui: StatisticUi.card);

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      value: json['value'].toDouble(),
      type: json['type'],
    );
  }
}

class ComparisonData extends StatisticData {
  final double lastMonth;
  final double currentMonth;

  ComparisonData({
    required this.lastMonth,
    required this.currentMonth,
    required super.type,
  }) : super(ui: StatisticUi.comparison);

  factory ComparisonData.fromJson(Map<String, dynamic> json) {
    return ComparisonData(
      lastMonth: json['last_month'].toDouble(),
      currentMonth: json['current_month'].toDouble(),
      type: json['type'],
    );
  }
}
