import 'measure_model.dart';

class HistoryData {
  final DateTime date;
  final List<MeasureData> measurements;

  HistoryData({
    required this.date,
    required this.measurements,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      date: DateTime.parse(json['date']),
      measurements: (json['measurements'] as List)
          .map((e) => MeasureData.fromJson(e))
          .toList(),
    );
  }
}
