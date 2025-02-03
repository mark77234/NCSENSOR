class HistoryData {
  final String id;
  final String title;
  final HistoryResult result;
  final DateTime datetime;

  HistoryData({
    required this.id,
    required this.title,
    required this.result,
    required this.datetime,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      id: json['id'],
      title: json['title'],
      result: HistoryResult.fromJson(json['result']),
      datetime: DateTime.parse(json['datetime']),
    );
  }
}

class HistoryResult {
  final double value;
  final String unit;
  final String content;

  HistoryResult({
    required this.value,
    required this.unit,
    required this.content,
  });

  factory HistoryResult.fromJson(Map<String, dynamic> json) {
    return HistoryResult(
      value: json['value'].toDouble(),
      unit: json['unit'],
      content: json['content'],
    );
  }
}