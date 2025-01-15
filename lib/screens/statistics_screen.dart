import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/styles.dart';
import '../models/measure_model.dart';
import '../models/statistic_data_model.dart';
import '../services/api_service.dart';
import '../widgets/carousel.dart';
import '../widgets/compare_graph_card.dart';
import '../widgets/my_card.dart';
import '../widgets/my_header.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  MeasureLabel? selectedLabel;
  List<MeasureLabel> measureLabels = [];
  List<StatisticData>? statisticData;
  bool _isLabelLoading = false;
  bool _isDataLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMeasureLabels();
  }

  Future<void> _loadMeasureLabels() async {
    setState(() {
      _isLabelLoading = true;
    });
    try {
      final labels = await ApiService.getMeasureLabel();
      setState(() {
        measureLabels = labels;
        selectedLabel = labels.isNotEmpty ? labels.first : null;
      });
      if (selectedLabel != null) {
        _loadStatisticData();
      }
    } catch (e) {
      print('Error loading measure labels: $e');
    }
    setState(() {
      _isLabelLoading = false;
    });
  }

  Future<void> _loadStatisticData() async {
    setState(() {
      _isDataLoading = true;
    });
    try {
      String labelId = selectedLabel!.id;
      final data = await ApiService.getStatisticData(labelId: labelId);
      setState(() {
        statisticData = data;
      });
    } catch (e, s) {
      print('Error loading statistic data: $e');
      print(s);
    }
    setState(() {
      _isDataLoading = false;
    });
  }

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
            if (_isLabelLoading)
              CircularProgressIndicator()
            else if (measureLabels.isEmpty)
              _buildEmptyState()
            else
              Column(
                children: [
                  _buildDropdown(),
                  SizedBox(height: 16),
                  if (_isDataLoading)
                    CircularProgressIndicator()
                  else if (statisticData != null)
                    ...statisticData!.map((view) => _buildViewContent(view)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewContent(StatisticData view) {
    switch (view.type) {
      case StaticViewType.card:
        return _buildCardContent(view as CardData);
      case StaticViewType.percent:
        return _buildPercentContent(view as PercentData);
      case StaticViewType.comparison:
        return _buildComparisonContent(view as ComparisonData);
      default:
        return SizedBox();
    }
  }

  Widget _buildCardContent(CardData card) {
    return MyCard(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(right: 2.0),
          child: SvgPicture.asset(
            "assets/${card.icon}",
            width: 40,
            height: 40,
          ),
        ),
        title: Text(
          card.title,
          style: TextStyles.label,
        ),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(card.value.toString(), style: TextStyles.title),
            SizedBox(width: 8),
            Text(card.unit.toString(),
                style: TextStyles.label.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildPercentContent(PercentData chart) {
    return MyCard(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Text(
              chart.title,
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
                  height: 145 * chart.value / chart.max,
                ),
              ),
              SvgPicture.asset(
                "assets/customGraph.svg",
                width: 96,
                height: 200,
              ),
            ]),
            Text(
              "${chart.value}${chart.unit}",
              style: TextStyles.title,
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonContent(ComparisonData data) {
    double carouselHeight = 300;
    return Carousel(
      length: data.charts.length,
      height: carouselHeight,
      builder: (BuildContext context, int index) {
        ComparisonChart chart = data.charts[index];
        return CompareGraphCard(
          data: chart,
          height: carouselHeight,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 48,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "조회할 통계가 없습니다.",
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

  Widget _buildDropdown() {
    return Container(
      width: 200,
      padding: EdgeInsets.all(4),
      decoration: ContainerStyles.tile.copyWith(color: ColorStyles.grey),
      child: DropdownButton<MeasureLabel>(
        value: selectedLabel,
        onChanged: (MeasureLabel? newValue) {
          setState(() {
            selectedLabel = newValue;
            if (newValue != null) _loadStatisticData();
          });
        },
        isExpanded: true,
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        underline: SizedBox(),
        isDense: true,
        borderRadius: RadiusStyles.common,
        items: measureLabels.map((MeasureLabel label) {
          return DropdownMenuItem<MeasureLabel>(
            value: label,
            child: Center(
              child: Text(
                label.name,
                style: TextStyles.subtitle.copyWith(
                  color: selectedLabel?.id == label.id
                      ? Colors.black
                      : ColorStyles.secondary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
