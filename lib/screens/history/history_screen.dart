import 'package:flutter/material.dart';

import '../../models/data/history_model.dart';
import '../../widgets/common/my_header.dart';
import '../../widgets/screens/history/date_selector.dart';
import '../../widgets/screens/history/history_list.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateRange? selectedRange = DateRange.thisMonth;
  DateTime currentMonth = DateTime.now();

  DateTimeRange get dateRange =>
      selectedRange?.dateRange ??
      DateTimeRange(
        start: DateTime(currentMonth.year, currentMonth.month, 1),
        end: DateTime(currentMonth.year, currentMonth.month + 1, 0),
      );

  void _updateMonth(DateTime newMonth) {
    setState(() {
      currentMonth = newMonth;
      selectedRange = null;
    });
  }

  void _updateRange(DateRange? range) {
    setState(() {
      currentMonth = DateTime.now();
      selectedRange = range;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MyHeader(title: "기록"),
            DateSelector(
              currentMonth: currentMonth,
              selectedRange: selectedRange,
              setDate: _updateMonth,
              setRange: _updateRange,
            ),
            SizedBox(height: 16),
            HistoryList(dateRange: dateRange),
          ],
        ),
      ),
    );
  }
}
