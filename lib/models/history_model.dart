import 'package:flutter/material.dart';

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

enum DateRange {
  thisMonth,
  sixMonths,
  oneYear,
}

extension DateRangeExtension on DateRange {
  String get displayName {
    switch (this) {
      case DateRange.thisMonth:
        return "이번 달";
      case DateRange.sixMonths:
        return "6개월";
      case DateRange.oneYear:
        return "1년";
    }
  }

  DateTimeRange get dateRange {
    final now = DateTime.now();
    DateTime startDate;
    DateTime endDate = DateTime(now.year, now.month + 1, 0); // 현재 달의 마지막 날

    switch (this) {
      case DateRange.thisMonth:
        startDate = DateTime(now.year, now.month, 1);
        break;
      case DateRange.sixMonths:
        startDate = DateTime(now.year, now.month - 5, 1);
        break;
      case DateRange.oneYear:
        startDate = DateTime(now.year - 1, now.month + 1, 1);
        break;//기본값: 이번 달
    }
    return DateTimeRange(start: startDate, end: endDate);
  }
}
