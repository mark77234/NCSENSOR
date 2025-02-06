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
  final num value;

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
  final num value;

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
  final List<ComparisonChart> charts;

  ComparisonData({
    required this.charts,
    required super.type,
  }) : super(ui: StatisticUi.comparison);

  factory ComparisonData.fromJson(Map<String, dynamic> json) {
    return ComparisonData(
      charts: (json['charts'] as List)
          .map((e) => ComparisonChart.fromJson(e))
          .toList(),
      type: json['type'] ?? "",
    );
  }
}

class ComparisonChart {
  final String type;
  final double lastMonth;
  final double currentMonth;

  ComparisonChart({
    required this.type,
    required this.lastMonth,
    required this.currentMonth,
  });

  factory ComparisonChart.fromJson(Map<String, dynamic> json) {
    return ComparisonChart(
      type: json['type'],
      lastMonth: json['last_month'].toDouble(),
      currentMonth: json['current_month'].toDouble(),
    );
  }
}
