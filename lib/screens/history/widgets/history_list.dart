import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/styles.dart';
import '../../../models/data/history_model.dart';
import '../../../models/meta/ncs_meta.dart';
import '../../../services/api_service.dart';
import '../../../storage/data/meta_storage.dart';
import '../../../utils/api_hook.dart';
import '../../../widgets/api_state_builder.dart';
import 'history_item.dart';

class HistoryList extends StatefulWidget {
  const HistoryList(
      {super.key, required this.dateRange, required this.currentMonth});

  final DateRange dateRange;
  final DateTime currentMonth;

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late final ApiHook<List<HistoryData>> historyApiHook;

  @override
  void initState() {
    super.initState();
    DateTimeRange currentRange =
        widget.dateRange.dateRange(widget.currentMonth);
    historyApiHook = ApiHook(
        apiCall: (params) => ApiService.getHistoryData(
              start: params['start'],
              end: params['end'],
            ),
        params: {
          'start': currentRange.start,
          'end': currentRange.end,
        });
    historyApiHook.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(covariant HistoryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    DateTimeRange currentRange =
        widget.dateRange.dateRange(widget.currentMonth);
    historyApiHook.updateParams({
      'start': currentRange.start,
      'end': currentRange.end,
    });
  }

  @override
  void dispose() {
    historyApiHook.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ApiStateBuilder(
      apiState: historyApiHook.state,
      title: "기록",
      icon: Icons.history,
      builder: (context, data) {
        final Map<String, List<HistoryData>> groupedRecords = {};
        for (HistoryData record in data!) {
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
      },
    );
  }

  Widget _buildDayGroup(String date, List<HistoryData> records) {
    final NcsMetaData uiData = UiStorage.data;

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
        ...records.map((record) {
          final article = uiData.findArticleById(record.articleId);
          if (article != null) {
            return HistoryItem(
              data: record,
              article: article,
            );
          }
          return SizedBox();
        }).toList(),
        SizedBox(height: 8),
      ],
    );
  }
}
