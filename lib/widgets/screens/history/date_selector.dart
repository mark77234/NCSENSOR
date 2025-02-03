import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/styles.dart';
import '../../../models/history_model.dart';

class DateSelector extends StatelessWidget {
  const DateSelector({
    super.key,
    required this.currentMonth,
    required this.selectedRange,
    required this.setDate,
    required this.setRange,
  });

  final DateTime currentMonth;
  final DateRange? selectedRange;
  final Function(DateTime newMonth) setDate;
  final Function(DateRange? range) setRange;

  bool _isDateAvailable(int delta) {
    final newMonth = DateTime(currentMonth.year, currentMonth.month + delta);
    return !newMonth.isAfter(DateTime.now());
  }

  void _changeMonth(int delta) {
    if (!_isDateAvailable(delta)) return;
    setDate(DateTime(currentMonth.year, currentMonth.month + delta));
    setRange(null);
  }

  @override
  Widget build(BuildContext context) {
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
      children:
          DateRange.values.map((range) => _buildRangeButton(range)).toList(),
    );
  }

  Widget _buildRangeButton(DateRange range) {
    final isSelected = selectedRange == range;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: () {
            DateRange? newRange = isSelected ? null : range;
            setRange(newRange);
          },
          style: _getRangeButtonStyle(isSelected),
          child: Text(
            range.displayName,
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
      backgroundColor: isSelected
          ? ColorStyles.primary.withAlpha(50)
          : ColorStyles.lightgrey,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
