import 'package:flutter/material.dart';
import 'package:taesung1/constants/styles.dart';

// highlightedDates has date, value objects
// ex) {"date": "2021-10-01", "value": "1"}

class HighlightedDate {
  DateTime date;
  int value;

  HighlightedDate(this.date, this.value);

  factory HighlightedDate.fromJson(Map<String, dynamic> json) {
    return HighlightedDate(
        DateTime.parse(json['date']), int.parse(json['value']));
  }

  @override
  String toString() {
    return "HighlightedDate(date: $date, value: $value)";
  }
}

class SimpleCalendar extends StatelessWidget {
  const SimpleCalendar({super.key, required this.highlightedDates});

  final List<HighlightedDate> highlightedDates;

  @override
  Widget build(BuildContext context) {
    // 현재 날짜 정보
    final today = DateTime.now();
    final firstDayOfMonth = DateTime(today.year, today.month, 1);
    final lastDayOfMonth = DateTime(today.year, today.month + 1, 0);

    // 첫 주의 요일 인덱스 (일: 0, 월: 1, ...)
    int startWeekday = firstDayOfMonth.weekday % 7;
    int daysInMonth = lastDayOfMonth.day;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${today.year}년 ${today.month}월 음주 기록",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 요일 헤더
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ["일", "월", "화", "수", "목", "금", "토"]
                    .map((day) => Text(day,
                        style: TextStyle(fontWeight: FontWeight.bold)))
                    .toList(),
              ),
              SizedBox(height: 8),
              // 날짜 표
              Table(
                children:
                    _buildCalendar(startWeekday, daysInMonth, highlightedDates),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<TableRow> _buildCalendar(int startWeekday, int daysInMonth,
      List<HighlightedDate> highlightedDates) {
    List<TableRow> rows = [];
    List<Widget> cells = [];

    // 빈 셀 채우기 (첫 주의 시작 요일 이전)
    for (int i = 0; i < startWeekday; i++) {
      cells.add(Container());
    }

    // 날짜 채우기
    for (int day = 1; day <= daysInMonth; day++) {
      int index =
          highlightedDates.indexWhere((element) => element.date.day == day);
      int highlightValue = index != -1 ? highlightedDates[index].value : 0;

      // bool isHighlighted =
      //     highlightedDates.any((element) => element.date.day == day);
      cells.add(_buildDateCell(day, highlightValue, 3));

      // 한 주가 끝날 때마다 줄 추가
      if ((cells.length) % 7 == 0) {
        rows.add(TableRow(children: cells));
        cells = [];
      }
    }

    // 마지막 줄 남은 셀 채우기
    if (cells.isNotEmpty) {
      while (cells.length < 7) {
        cells.add(Container());
      }
      rows.add(TableRow(children: cells));
    }

    return rows;
  }

  Widget _buildDateCell(int day, int highlightValue, int maxValue) {
    // opacity change by highlightValue/maxValue

    double opacity = highlightValue / maxValue;

    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: highlightValue > 0
            ? ColorStyles.primary.withAlpha((opacity * 255).toInt())
            : null,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        day.toString(),
        style: TextStyle(
          color: highlightValue > 0 ? Colors.white : Colors.black,
          fontWeight: highlightValue > 0 ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
