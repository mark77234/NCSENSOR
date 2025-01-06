import 'package:flutter/material.dart';
import 'package:taesung1/constants/styles.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedPeriod = '월별';

  Widget _buildPeriodTile(String period) {
    return ListTile(
      title: Text(period, style: TextStyles.body),
      onTap: () {
        setState(() {
          _selectedPeriod = period;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 8.0, bottom: 8.0),
            child: SizedBox(
              width: 100,
              height: 200,
              child: SingleChildScrollView(
                child: ExpansionTile(
                  title: Text(
                    _selectedPeriod,
                    style: TextStyles.body,
                  ),
                  tilePadding: EdgeInsets.symmetric(horizontal: 1),
                  children: [
                    _buildPeriodTile('주별'),
                    _buildPeriodTile('월별'),
                    _buildPeriodTile('년별'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}