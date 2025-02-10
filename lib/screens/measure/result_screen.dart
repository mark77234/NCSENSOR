import 'package:NCSensor/storage/data/ui_storage.dart';
import 'package:NCSensor/widgets/common/error_screen.dart';
import 'package:NCSensor/widgets/screens/result/result_card.dart';
import 'package:flutter/material.dart';

import '../../models/data/result_model.dart';
import '../../models/ui/article_model.dart';
import '../../services/api_service.dart';
import '../../widgets/screens/result/action_button.dart';
import '../../widgets/screens/result/status_card.dart';

class ResultScreen extends StatefulWidget {
  final String articleId;

  const ResultScreen(this.articleId, {super.key});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // 세로 기준 가운데 정렬
              crossAxisAlignment: CrossAxisAlignment.center, // 가로 기준 가운데 정렬 (선택사항)

            children: [
              const SizedBox(height: 20),
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
      ),
    );
  }
}
