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
  // 날짜별 센서 데이터
  final List<String> ranges = ["이번 달", "6개월", "1년"];
  String? selectedRange = "이번 달";

  List<HistoryData> records = [];

  @override
  void initState() {

    for (var data in historyData) {
      records.add(HistoryData.fromJson(data));
    }
    super.initState();
    fetchHistoryData().then((_) {
      setState(() {
        // 데이터 로드 후 UI 업데이트
        records = historyData.map((data) => HistoryData.fromJson(data)).toList();
      });
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
            SizedBox(height: 8),
            Center(child: Text("측정 기록", style: TextStyles.title)),
            SizedBox(height: 16),
            Container(
                decoration: ContainerStyles.card,
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left,
                              color: Colors.grey.shade600),
                          onPressed: () {},
                        ),
                        Text(
                          "2025년 1월",
                          style: TextStyles.subtitle,
                        ),
                        IconButton(
                          icon: Icon(Icons.chevron_right,
                              color: Colors.grey.shade600),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      children: ranges.map((range) {
                        final isSelected = selectedRange == range;
                        return Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedRange = isSelected ? null : range;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: isSelected
                                    ? ColorStyles.primary
                                    : ColorStyles.secondary,
                                backgroundColor: isSelected
                                    ? ColorStyles.primary.withAlpha(50)
                                    : ColorStyles.grey,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(range,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  )),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                )),
            SizedBox(height: 16),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
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
                      ...record.measurements.map((measurement) {
                        return Container(
                            decoration: ContainerStyles.card,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.only(right: 2.0),
                                child: SvgPicture.asset(
                                  "assets/${measurement is OdorData ? measurement.subType.name : measurement.type.name}.svg",
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                              title: Text(
                                measurement.typeToKor(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                DateFormat("HH:mm")
                                    .format(measurement.dateTime),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              trailing: Column(
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
                              ),
                            )
                            // Row(
                            //   children: [
                            //     Container(
                            //       padding: const EdgeInsets.all(8),
                            //       decoration: BoxDecoration(
                            //         color: measurement.color.withOpacity(0.2),
                            //         borderRadius: BorderRadius.circular(8),
                            //       ),
                            //       child: SvgPicture.asset(
                            //         "assets/${measurement is OdorData ? measurement.subType.name : measurement.type.name}.svg",
                            //         width: 40,
                            //         height: 40,
                            //       ),
                            //     ),
                            //     SizedBox(width: 16),
                            //     Expanded(
                            //       child: Column(
                            //         crossAxisAlignment: CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             measurement.typeToKor(),
                            //             style: TextStyle(
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //           Text(
                            //             "${measurement.value} ${measurement.unit}",
                            //             style: TextStyle(
                            //               fontSize: 14,
                            //               color: Colors.grey.shade600,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     Text(
                            //       measurement.message,
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //         color: measurement.color,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            );
                      }),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
