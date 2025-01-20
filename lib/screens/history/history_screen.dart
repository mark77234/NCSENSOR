import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../constants/styles.dart';
import '../../models/history_model.dart';
import '../../services/api_service.dart';
import '../../widgets/common/my_header.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  static const List<String> _dateRanges = ["이번 달", "6개월", "1년"];

  String? selectedRange = "이번 달";
  List<HistoryData> records = [];
  DateTime currentMonth = DateTime.now();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadHistoryData();
  }

  DateTimeRange _getDateRange() {
    final now = DateTime.now();
    DateTime startDate;
    DateTime endDate = DateTime(now.year, now.month + 1, 0); // 현재 달의 마지막 날

    switch (selectedRange) {
      case "이번 달":
        startDate = DateTime(now.year, now.month, 1);
        break;
      case "6개월":
        startDate = DateTime(now.year, now.month - 5, 1);
        break;
      case "1년":
        startDate = DateTime(now.year - 1, now.month + 1, 1);
        break;
      default:
        // 기본값: 이번 달
        startDate = DateTime(now.year, now.month, 1);
    }

    return DateTimeRange(start: startDate, end: endDate);
  }

  Future<void> _loadHistoryData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DateTimeRange dateRange;

      if (selectedRange != null) {
        dateRange = _getDateRange();
      } else {
        // 월 선택 시 해당 월의 시작일과 마지막일
        dateRange = DateTimeRange(
          start: DateTime(currentMonth.year, currentMonth.month, 1),
          end: DateTime(currentMonth.year, currentMonth.month + 1, 0),
        );
      }

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

  bool _isDateAvailable(int delta) {
    final newMonth = DateTime(currentMonth.year, currentMonth.month + delta);
    return !newMonth.isAfter(DateTime.now());
  }

  void _changeMonth(int delta) {
    if (!_isDateAvailable(delta)) return;

    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + delta);
      selectedRange = null;
      _loadHistoryData(); // 월 변경 시 선택된 범위 초기화
    });

    // 새로운 월의 데이터 로드
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
            _buildDateSelector(),
            SizedBox(height: 16),
            if (_isLoading)
              Center(child: CircularProgressIndicator())
            else if (records.isEmpty)
              _buildEmptyState()
            else
              _buildHistoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 48,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "기록이 없습니다.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      decoration: ContainerStyles.card,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildMonthSelector(),
          _buildRangeSelector(),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMonthButton(-1),
        Text(
          DateFormat("yyyy년 MM월").format(currentMonth),
          style: TextStyles.subtitle,
        ),
        _buildMonthButton(1),
      ],
    );
  }

  Widget _buildMonthButton(int delta) {
    return IconButton(
      icon: Icon(delta < 0 ? Icons.chevron_left : Icons.chevron_right),
      onPressed: _isDateAvailable(delta) ? () => _changeMonth(delta) : null,
      color: Colors.grey.shade600,
      disabledColor: Colors.grey.shade300,
    );
  }

  Widget _buildRangeSelector() {
    return Row(
      children: _dateRanges.map((range) => _buildRangeButton(range)).toList(),
    );
  }

  Widget _buildRangeButton(String range) {
    final isSelected = selectedRange == range;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              selectedRange = isSelected ? null : range;
              _loadHistoryData(); // 범위 변경 시 데이터 다시 로드
            });
          },
          style: _getRangeButtonStyle(isSelected),
          child: Text(
            range,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _getRangeButtonStyle(bool isSelected) {
    return ElevatedButton.styleFrom(
      foregroundColor: isSelected ? ColorStyles.primary : ColorStyles.secondary,
      backgroundColor:
          isSelected ? ColorStyles.primary.withAlpha(50) : ColorStyles.grey,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildHistoryList() {
    // 날짜별로 기록 그룹화
    Map<String, List<HistoryData>> groupedRecords = {};
    for (var record in records) {
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
        ...dayRecords.map((record) => _buildHistoryItem(record)).toList(),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _buildHistoryItem(HistoryData record) {
    return Container(
      decoration: ContainerStyles.card,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: _buildHistoryIcon(record.title),
        title: Text(
          record.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat('HH:mm').format(record.datetime),
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${record.result.value} ${record.result.unit}",
              style: TextStyle(
                fontSize: 14,
                color: ColorStyles.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              record.result.content,
              style: TextStyle(
                fontSize: 14,
                color: ColorStyles.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryIcon(String title) {
    String assetName;

    switch (title) {
      case "음주":
        assetName = "drinking";
        break;
      case "입냄새":
        assetName = "mouth";
        break;
      case "겨드랑이냄새":
        assetName = "armpit";
        break;
      case "발냄새":
        assetName = "foot";
        break;
      default:
        assetName = "measure";
    }

    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: SvgPicture.asset(
        "assets/$assetName.svg",
        width: 40,
        height: 40,
      ),
    );
  }
}
