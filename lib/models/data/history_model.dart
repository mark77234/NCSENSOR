import 'package:flutter/material.dart';

class HistoryData {
  final String id;
  final String articleId;
  final double value;
  final DateTime datetime;

  HistoryData({
    required this.id,
    required this.articleId,
    required this.value,
    required this.datetime,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      id: json['id'],
      articleId: json['article_id'],
      value: json['value'].toDouble(),
      datetime: DateTime.parse(json['datetime']),
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
        return "1개월";
      case DateRange.sixMonths:
        return "6개월";
      case DateRange.oneYear:
        return "1년";
    }
  }

  DateTimeRange dateRange(DateTime? standard) {
    standard ??= DateTime.now();
    DateTime startDate;
    DateTime endDate =
        DateTime(standard.year, standard.month + 1, 0); // 현재 달의 마지막 날

    switch (this) {
      case DateRange.thisMonth:
        startDate = DateTime(standard.year, standard.month, 1);
        break;
      case DateRange.sixMonths:
        startDate = DateTime(standard.year, standard.month - 5, 1);
        break;
      case DateRange.oneYear:
        startDate = DateTime(standard.year - 1, standard.month + 1, 1);
        break; //기본값: 이번 달
    }
    return DateTimeRange(start: startDate, end: endDate);
  }
}
