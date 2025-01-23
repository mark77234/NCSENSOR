import 'package:flutter/material.dart';

import '../models/history_model.dart';
import '../services/api_service.dart';
import '../widgets/common/empty_display_box.dart';
import '../widgets/common/my_header.dart';
import '../widgets/screens/history/history.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateRange? selectedRange = DateRange.thisMonth;
  List<HistoryData> records = [];
  DateTime currentMonth = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadHistoryData();
  }

  Future<void> _loadHistoryData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DateTimeRange dateRange = selectedRange?.dateRange ??
          DateTimeRange(
            start: DateTime(currentMonth.year, currentMonth.month, 1),
            end: DateTime(currentMonth.year, currentMonth.month + 1, 0),
          );

      final data = await ApiService.getHistoryData(
        start: dateRange.start,
        end: dateRange.end,
      );

      setState(() {
        records = data;
      });
    } catch (e) {
      print('Error loading history data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
              loadData: _loadHistoryData,
              currentMonth: currentMonth,
              selectedRange: selectedRange,
              setDate: _updateMonth,
              setRange: _updateRange,
            ),
            SizedBox(height: 16),
            if (_isLoading)
              Center(child: CircularProgressIndicator())
            else if (records.isEmpty)
              EmptyDisplayBox(
                icon: Icons.history,
                text: "기록이 없습니다.",
              )
            else
              HistoryList(records: records),
          ],
        ),
      ),
    );
  }
}
