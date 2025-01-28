import 'package:flutter/material.dart';
import 'package:taesung1/utils/api_hook.dart';

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
  late final ApiHook historyApiHook;
  DateRange? selectedRange = DateRange.thisMonth;
  DateTime currentMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    historyApiHook =
        ApiHook<List<HistoryData>>(apiCall: ApiService.getHistoryData, params: {
      'start': dateRange.start,
      'end': dateRange.end,
    });
    historyApiHook.addListener(() {
      setState(() {});
    });
  }

  DateTimeRange get dateRange =>
      selectedRange?.dateRange ??
      DateTimeRange(
        start: DateTime(currentMonth.year, currentMonth.month, 1),
        end: DateTime(currentMonth.year, currentMonth.month + 1, 0),
      );

  @override
  void didUpdateWidget(covariant HistoryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    historyApiHook.updateParams({
      'start': dateRange.start,
      'end': dateRange.end,
    });
  }

  @override
  void dispose() {
    historyApiHook.dispose();
    super.dispose();
  }

  // Future<void> _loadHistoryData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //
  //   try {
  //
  //     final data = await ApiService.getHistoryData(
  //       start: dateRange.start,
  //       end: dateRange.end,
  //     );
  //
  //     setState(() {
  //       records = data;
  //     });
  //   } catch (e) {
  //     print('Error loading history data: $e');
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

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
            if (historyApiHook.state.isLoading)
              Center(child: CircularProgressIndicator())
            else if (historyApiHook.state.data.isEmpty)
              EmptyDisplayBox(
                icon: Icons.history,
                text: "기록이 없습니다.",
              )
            else
              HistoryList(records: historyApiHook.state.data),
          ],
        ),
      ),
    );
  }
}
