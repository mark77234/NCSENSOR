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

  static const _testsensors = [
    {"sensor_id": "1", "value": 0, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "2", "value": 2, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "3", "value": 3, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "4", "value": 5, "measured_at": "2025-01-22T00:00:00"},
  ];

  @override
  void initState() {
    super.initState();
    _loadResultData();
  }


  Future<void> _loadResultData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2));
      final response = await ApiService.getBodyData(widget.articleId, _testsensors);
      setState(() {
        measuredValue = response.value;
        comment = response.comment;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "데이터를 불러오는데 실패했습니다.";
      });
      print("오류: $e");
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uiData = UiStorage.data;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return ErrorScreen(errorMessage: _errorMessage);
    }

    if (measuredValue == null || comment == null) {
      return ErrorScreen(errorMessage: _errorMessage);
    }

    ArticleMeta? article;
    for (var a in uiData.articles) {
      if (a.id == widget.articleId) {
        article = a;
        break;
      }
    }

    if (article == null ) {
      return ErrorScreen(errorMessage: _errorMessage);
    }

    final result = article.result;
    final sections = article.sections;
    final title = article.result?.title;
    final unit = article.unit;

    if (result == null || sections == null) {
      return ErrorScreen(errorMessage: _errorMessage);
    }

    int stage = 0;
    for (int i = 0; i < sections.length; i++) {
      final section = sections[i];
      final min = section.min.value;
      final max = section.max.value;
      final isMinContained = section.min.isContained;
      final isMaxContained = section.max.isContained;

      if ((isMinContained ? measuredValue! >= min : measuredValue! > min) &&
          (isMaxContained ? measuredValue! <= max : measuredValue! < max)) {
        stage = i;
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title!,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              ResultCard(
                stage: stage,
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
