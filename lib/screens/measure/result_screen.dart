import 'package:NCSensor/storage/data/meta_storage.dart';
import 'package:NCSensor/widgets/common/error_screen.dart';
import 'package:NCSensor/widgets/screens/main/ncsAppBar.dart';
import 'package:NCSensor/widgets/screens/main/ncsBottomNavigationBar.dart';
import 'package:NCSensor/widgets/screens/result/result_card.dart';
import 'package:flutter/material.dart';

import 'package:NCSensor/screens/history/history_screen.dart';
import 'package:NCSensor/screens/profile/profile_screen.dart';
import 'package:NCSensor/screens/statistics/statistics_screen.dart';

import '../../models/data/result_model.dart';
import '../../models/meta/article_model.dart';
import '../../services/api_service.dart';
import '../../widgets/screens/result/action_button.dart';
import '../../widgets/screens/result/status_card.dart';

class ResultScreen extends StatefulWidget {
  final String articleId;

  const ResultScreen(this.articleId, {super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int _selectedIndex = 0;

  final List<PageData> navPages = []; // 이동: initState로 이전

  @override
  void initState() {
    super.initState();
    navPages.addAll([
      PageData(_ResultContent(articleId: widget.articleId), '항목', Icons.home),
      PageData(const HistoryScreen(), '기록', Icons.history),
      PageData(const StatisticsScreen(), '통계', Icons.analytics_outlined),
      PageData(const ProfileScreen(), '프로필', Icons.person),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NCSAppBar(title: "결과"),
      body: SafeArea(child: navPages[_selectedIndex].widget),
      bottomNavigationBar: NCSBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _ResultContent extends StatefulWidget {
  final String articleId;

  const _ResultContent({required this.articleId});

  @override
  State<_ResultContent> createState() => _ResultContentState();
}

class _ResultContentState extends State<_ResultContent> {
  double? measuredValue;
  bool _isLoading = true;
  String? _errorMessage;
  String? comment;

  BodyResultData? bodyResultData;

  static const _testSensors = [
    {"sensor_id": "1", "value": 0, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "2", "value": 2, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "3", "value": 3, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "4", "value": 5, "measured_at": "2025-01-22T00:00:00"},
  ];

  ArticleMeta? _article;

  late final result;
  late final sections;
  late final title;
  late final unit;

  @override
  void initState() {
    super.initState();
    _loadResultData();
  }

  Future<void> _loadResultData() async {
    await _loadUiData();

    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));
      final response =
          await ApiService.getBodyData(widget.articleId, _testSensors);
      setState(() {
        measuredValue = response.value;
        comment = response.comment;
      });
    } catch (e) {
      setState(() {
        ErrorScreen(errorMessage: _errorMessage);
      });
      print("오류: $e");
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadUiData() async {
    final uiData = UiStorage.data;
    try {
      for (var article in uiData.articles) {
        if (article.id == widget.articleId) {
          _article = article;
          break;
        }
      }
      result = _article!.result;
      sections = _article!.sections;
      title = _article!.result.title;
      unit = _article!.unit;
    } catch (e) {
      ErrorScreen(errorMessage: _errorMessage);
    }
  }

  int get _stage{
    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      final min = section.min.value;
      final max = section.max.value;
      final isMinContained = section.min.isContained;
      final isMaxContained = section.max.isContained;

      if ((isMinContained ? measuredValue! >= min : measuredValue! > min) &&
          (isMaxContained ? measuredValue! <= max : measuredValue! < max)) {
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ResultCard(
              stage: _stage,
              result: result,
              sections: sections,
              value: measuredValue!,
              unit: unit,
              comment: comment,
            ),
            const SizedBox(height: 20),
            // _buildStatusCard(sections, title),
            StatusCard(
              sections: sections,
              title: title,
            ),
            const SizedBox(height: 20),
            ActionButton(
              context: context,
              uuid: widget.articleId,
            )
          ],
        ),
      ),
    );
  }
}
