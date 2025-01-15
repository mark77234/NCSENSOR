import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/mockData.dart';
import '../constants/styles.dart';
import '../models/measure_model.dart';
import '../widgets/carousel.dart';
import '../widgets/compare_graph_card.dart';
import '../widgets/my_card.dart';
import '../widgets/my_header.dart';
import '../widgets/simple_calendar.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  MeasureType selectedType = MeasureType.drinking;

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
              MyHeader(title: "통계"),
              _buildDropdown(),
              SizedBox(height: 16),
              for (var item in data[selectedType.name]!)
                _buildTypeContent(item),
            ]),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      width: 200,
      padding: EdgeInsets.all(4),
      decoration: ContainerStyles.tile.copyWith(color: ColorStyles.grey),
      child: DropdownButton<MeasureType>(
        value: selectedType,
        onChanged: (MeasureType? newValue) {
          setState(() {
            selectedType = newValue!;
          });
        },
        isExpanded: true,
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        underline: SizedBox(),
        isDense: true,
        borderRadius: RadiusStyles.common,
        items: _buildDropdownItems(),
      ),
    );
  }

  List<DropdownMenuItem<MeasureType>> _buildDropdownItems() {
    return MeasureType.values.map((MeasureType type) {
      return DropdownMenuItem<MeasureType>(
        value: type,
        child: Center(
          child: Text(
            type == MeasureType.drinking ? "음주" : "체취",
            style: TextStyles.subtitle.copyWith(
              color:
                  selectedType == type ? Colors.black : ColorStyles.secondary,
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildTypeContent(var data) {
    switch (data["type"]) {
      case "tile":
        return _buildTileContent(data);
      case "calendar":
        return _buildCalendarContent(data);
      case "customGraph":
        return _buildCustomGraphContent(data);
      case "compareGraph":
        return _buildCompareGraphContent(data);
      default:
        return Text("Error");
    }
  }

  Widget _buildTileContent(var data) {
    return MyCard(
      child: ListTile(
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
      ),
    );
  }

  Widget _buildCalendarContent(var data) {
    List<HighlightedDate> highlightedDates = (data["value"]! as List)
        .map((e) => HighlightedDate.fromJson(e))
        .toList();
    return MyCard(
      child: SimpleCalendar(
        highlightedDates: highlightedDates,
      ),
    );
  }

  Widget _buildCustomGraphContent(var data) {
    return MyCard(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Text(
              data["title"],
              style: TextStyle(fontWeight: FontWeight.bold),
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
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildCompareGraphContent(var data) {
    double carousalHeight = 300;
    double maxValue = 5;
    return Carousel(
      length: data["list"].length,
      height: carousalHeight,
      builder: (BuildContext context, int index) {
        CompareGraphData item = CompareGraphData.fromJson(data["list"][index]);
        return CompareGraphCard(
          item: item,
          maxValue: maxValue,
          height: carousalHeight,
        );
      },
    );
  }
}
