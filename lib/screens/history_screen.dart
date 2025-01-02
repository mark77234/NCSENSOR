import 'package:flutter/material.dart';

import '../constants/styles.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // 날짜별 센서 데이터
  Map<String, Map<String, dynamic>> data = {
    "2025-01-01": {
      "음주": 0.08,
      "체취": {"입": 2.1, "발": 1.8, "겨드랑이": 2.5}
    },
    "2025-01-02": {
      "음주": 0.05,
      "체취": {"입": 1.5, "발": 1.2, "겨드랑이": 2.0}
    },
    // 추가 데이터
  };

  String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: OutlinedButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (pickedDate != null) {
                setState(() {
                  selectedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                });
              }
            },
            style: ButtonStyles.outlined,
            child: Text(selectedDate??"날짜를 선택하세요"),
          ),
        ),
        // 센서 데이터 표시
        if (data[selectedDate] != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  "음주",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "${data[selectedDate]?["음주"]}",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  "체취",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "입: ${data[selectedDate]?["체취"]?["입"]}",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "발: ${data[selectedDate]?["체취"]?["발"]}",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "겨드랑이: ${data[selectedDate]?["체취"]?["겨드랑이"]}",
                  style: TextStyle(fontSize: 16),
                ),


              ],
            ),
          )
      ],
    );
  }


}