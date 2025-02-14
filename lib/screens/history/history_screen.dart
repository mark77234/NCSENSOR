import 'package:NCSensor/screens/history/widgets/history_list.dart';
import 'package:flutter/material.dart';

import '../../models/data/history_model.dart';
import 'widgets/date_selector.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateRange selectedRange = DateRange.thisMonth;
  DateTime currentMonth = DateTime.now();

  void _updateMonth(DateTime newMonth) {
    setState(() {
      currentMonth = newMonth;
    });
  }

  void _updateRange(DateRange range) {
    setState(() {
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
            DateSelector(
              currentMonth: currentMonth,
              selectedRange: selectedRange,
              setDate: _updateMonth,
              setRange: _updateRange,
            ),
            SizedBox(height: 16),
            HistoryList(dateRange: selectedRange, currentMonth: currentMonth),
          ],
        ),
      ),
    );
  }
}
