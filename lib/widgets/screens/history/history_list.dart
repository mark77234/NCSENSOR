import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/styles.dart';
import '../../../models/data/history_model.dart';
import '../../../services/api_service.dart';
import '../../../utils/api_hook.dart';
import '../../common/empty_display_box.dart';
import 'history_item.dart';

class HistoryList extends StatefulWidget {
  const HistoryList({super.key, required this.dateRange});

  final DateTimeRange dateRange;

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late final ApiHook historyApiHook;

  @override
  void initState() {
    super.initState();
    historyApiHook = ApiHook<List<HistoryData>>(
        apiCall: (params) => ApiService.getHistoryData(
              start: params['start'],
              end: params['end'],
            ),
        params: {
          'start': widget.dateRange.start,
          'end': widget.dateRange.end,
        });
    historyApiHook.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant HistoryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    historyApiHook.updateParams({
      'start': widget.dateRange.start,
      'end': widget.dateRange.end,
    });
  }

  @override
  void dispose() {
    historyApiHook.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ApiState(:isLoading, :data, :error) = historyApiHook.state;
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return EmptyDisplayBox(
        icon: Icons.error,
        text: "기록을 불러오는 중 오류가 발생했습니다.",
      );
    }
    if (data?.isEmpty ?? true) {
      return EmptyDisplayBox(
        icon: Icons.history,
        text: "기록이 없습니다.",
      );
    }
    final Map<String, List<HistoryData>> groupedRecords = {};
    for (HistoryData record in data) {
      String dateKey = DateFormat('yyyy년 MM월 dd일').format(record.datetime);
      groupedRecords.putIfAbsent(dateKey, () => []).add(record);
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: groupedRecords.length,
      itemBuilder: (context, index) {
        String date = groupedRecords.keys.elementAt(index);
        List<HistoryData> dayRecords = groupedRecords[date]!;
        return _buildDayGroup(date, dayRecords);
      },
    );
  }

  Widget _buildDayGroup(String date, List<HistoryData> dayRecords) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            date,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorStyles.secondary,
            ),
          ),
        ),
        ...dayRecords.map((record) => HistoryItem(record: record)),
        SizedBox(height: 8),
      ],
    );
  }
}
