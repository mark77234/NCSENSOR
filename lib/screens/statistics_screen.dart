import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../constants/styles.dart';


class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String activeTab = "weekly";

  final List<Map<String, dynamic>> weeklyData = [
    {"day": "월", "alcohol": 0.03, "mouth": 0.2, "feet": 0.3},
    {"day": "화", "alcohol": 0.08, "mouth": 0.4, "feet": 0.5},
    {"day": "수", "alcohol": 0.12, "mouth": 0.7, "feet": 0.8},
    {"day": "목", "alcohol": 0.05, "mouth": 0.3, "feet": 0.2},
    {"day": "금", "alcohol": 0.09, "mouth": 0.8, "feet": 0.9},
    {"day": "토", "alcohol": 0.07, "mouth": 0.5, "feet": 0.4},
    {"day": "일", "alcohol": 0.04, "mouth": 0.2, "feet": 0.3},
  ];

  final List<Map<String, dynamic>> monthlyData = [
    {"week": "1주", "alcohol": 0.06, "mouth": 0.3, "feet": 0.4},
    {"week": "2주", "alcohol": 0.08, "mouth": 0.5, "feet": 0.6},
    {"week": "3주", "alcohol": 0.05, "mouth": 0.2, "feet": 0.3},
    {"week": "4주", "alcohol": 0.07, "mouth": 0.4, "feet": 0.5},
  ];

  @override
  Widget build(BuildContext context) {
    final data = activeTab == "weekly" ? weeklyData : monthlyData;

    return Column(
      children: [
        // 탭 전환 버튼
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => activeTab = "weekly"),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: activeTab == "weekly"
                            ?  ColorStyles.primary
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    "주간 통계",
                    style: TextStyle(
                      fontWeight: activeTab == "weekly"
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: activeTab == "weekly"
                          ?  ColorStyles.primary
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => activeTab = "monthly"),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: activeTab == "monthly"
                            ?  ColorStyles.primary
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    "월간 통계",
                    style: TextStyle(
                      fontWeight: activeTab == "monthly"
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: activeTab == "monthly"
                          ?  ColorStyles.primary
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "혈중알콜농도",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                // 바 차트
                Expanded(
                  child: BarChart(
                    BarChartData(
                      barGroups: data.map((item) {
                        final value = item["alcohol"] as double;
                        return BarChartGroupData(
                          x: data.indexOf(item),
                          barRods: [
                            BarChartRodData(
                              toY: value,
                              color:  ColorStyles.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        );
                      }).toList(),
                      titlesData: FlTitlesData(
                        leftTitles:AxisTitles (
                            sideTitles:SideTitles(showTitles: true)),
                        bottomTitles:AxisTitles (
                          sideTitles: SideTitles(
                            showTitles: true,
                          ),
                          axisNameWidget : Text("요일"),
                          // getTitles: (value) => data[value.toInt()]
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "체취 강도",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                // 라인 차트
                Expanded(
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: data.map((item) {
                            return FlSpot(
                                data.indexOf(item).toDouble(),
                                item["mouth"] as double);
                          }).toList(),
                          isCurved: true,
                          color: Color(0xFFF59E0B),
                          barWidth: 3,
                        ),
                        LineChartBarData(
                          spots: data.map((item) {
                            return FlSpot(
                                data.indexOf(item).toDouble(),
                                item["feet"] as double);
                          }).toList(),
                          isCurved: true,
                          color: Color(0xFF10B981),
                          barWidth: 3,
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles:  SideTitles(
                            showTitles: true,
                            // getTitles: (value) => data[value.toInt()]
                            // [activeTab == "weekly" ? "day" : "week"],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}