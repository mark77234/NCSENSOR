import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/mockData.dart';
import '../constants/styles.dart';
import '../widgets/simple_calendar.dart';

enum StatisticsType {
  drinking,
  odor,
}

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  StatisticsType selectedType = StatisticsType.drinking;

  final data = staticData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 8),
              Text("통계", style: TextStyles.title),
              SizedBox(height: 16),
              Container(
                width: 200,
                padding: EdgeInsets.all(4),
                decoration:
                    ContainerStyles.tile.copyWith(color: ColorStyles.grey),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTab("음주", myType: StatisticsType.drinking),
                    _buildTab("체취", myType: StatisticsType.odor),
                  ],
                ),
              ),
              SizedBox(height: 16),
              for (var item in data[selectedType.name]!)
                Container(
                  decoration: ContainerStyles.card,
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.only(bottom: 12),
                  child: _typeContent(item),
                ),
            ]),
      ),
    );
  }

  Widget _buildTab(String text, {required StatisticsType myType}) {
    bool isSelected = selectedType == myType;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = myType;
        });
      },
      child: Container(
        width: 96,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _typeContent(var data) {
    if (data["type"] == "tile") {
      return ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: SvgPicture.asset(
            data["icon"],
            width: 40,
            height: 40,
          ),
        ),
        title: Text(
          data["title"],
          style: TextStyles.label,
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(data["value"], style: TextStyles.title),
            SizedBox(width: 8),
            Text(data["unit"],
                style: TextStyles.label.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }
    if (data["type"] == "calendar") {
      List<HighlightedDate> highlightedDates = (data["value"]! as List)
          .map((e) => HighlightedDate.fromJson(e))
          .toList();
      return SimpleCalendar(
        highlightedDates: highlightedDates,
      );
    }
    if (data["type"] == "customGraph") {
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Text(
              data["title"],
              style: TextStyles.label
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Stack(children: [
              Positioned(
                left: 24,
                bottom: 20,
                child: Container(
                  color: Color(0xFF57D655),
                  width: 40,
                  height: 145 * double.parse(data["value"]) / 0.1,
                ),
              ),
              SvgPicture.asset(
                data["icon"],
                width: 96,
                height: 200,
              ),
            ]),
            Text(
              data["value"] + "%",
              style: TextStyles.title,
            ),
          ],
        ),
      );
    }

    return Text("Error");
  }
}
