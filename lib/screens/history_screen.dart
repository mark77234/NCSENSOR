import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../constants/mockData.dart';
import '../constants/styles.dart';
import '../models/history_model.dart';
import '../models/measure_model.dart';

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

  @override
  void initState() {
    super.initState();
    _loadHistoryData();
  }

  void _loadHistoryData() {
    setState(() {
      records = historyData.map((data) => HistoryData.fromJson(data)).toList();
    });
  }

  bool _isDateAvailable(int delta) {
    final newMonth = DateTime(currentMonth.year, currentMonth.month + delta);
    return !newMonth.isAfter(DateTime.now());
  }

  void _changeMonth(int delta) {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + delta);
      selectedRange = null;
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
            _buildHeader(),
            _buildDateSelector(),
            SizedBox(height: 16),
            _buildHistoryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(height: 8),
        Center(child: Text("측정 기록", style: TextStyles.title)),
        SizedBox(height: 16),
      ],
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
          onPressed: () => setState(() {
            selectedRange = isSelected ? null : range;
          }),
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
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: records.length,
      itemBuilder: (context, index) => _buildHistoryItem(records[index]),
    );
  }

  Widget _buildHistoryItem(HistoryData record) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat("yyyy년 MM월 dd일").format(record.date),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 8),
        ...record.measurements.map(_buildMeasurementItem),
      ],
    );
  }

  Widget _buildMeasurementItem(MeasureData measurement) {
    return Container(
      decoration: ContainerStyles.card,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: _buildMeasurementIcon(measurement),
        title: Text(
          measurement.typeToKor(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          DateFormat("HH:mm").format(measurement.dateTime),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: _buildMeasurementValue(measurement),
      ),
    );
  }

  Widget _buildMeasurementIcon(MeasureData measurement) {
    final iconName = measurement is OdorData
        ? measurement.subType.name
        : measurement.type.name;

    return Padding(
      padding: const EdgeInsets.only(right: 2.0),
      child: SvgPicture.asset(
        "assets/$iconName.svg",
        width: 40,
        height: 40,
      ),
    );
  }

  Widget _buildMeasurementValue(MeasureData measurement) {
    return Column(
      children: [
        Text(
          "${measurement.value} ${measurement.unit}",
          style: TextStyle(
            fontSize: 14,
            color: measurement.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          measurement.message,
          style: TextStyle(
            fontSize: 14,
            color: measurement.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
