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
  final String UUID;

  const ResultScreen(this.UUID, {super.key});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late String articleId;
  double? measuredValue;
  bool _isLoading = true;
  String? _errorMessage;
  String? comment;

  BodyResultData? bodyResultData;

  List<Map<String, dynamic>> sensors = [
    {"sensor_id": "1", "value": 0, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "2", "value": 2, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "3", "value": 3, "measured_at": "2025-01-22T00:00:00"},
    {"sensor_id": "4", "value": 5, "measured_at": "2025-01-22T00:00:00"},
  ];

  @override
  void initState() {
    super.initState();
    articleId = widget.UUID;
    _loadData();
    _loadResultData(articleId, sensors);
  }

  Future<void> _loadResultData(
      String articleId, List<Map<String, dynamic>> sensors) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final data = await ApiService.getBodyData(articleId, sensors);
      setState(() {
        measuredValue = data.value;
        comment = data.comment;
      });
    } catch (e) {
      print("오류: $e");
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _loadData() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "데이터를 불러오는데 실패했습니다.";
        _isLoading = false;
      });
    }
  }

  String getCurrentDateTime() {
    return DateTime.now().toString().substring(0, 16);
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

    if (uiData == null || measuredValue == null || comment == null) {
      return ErrorScreen(errorMessage: _errorMessage);
    }

    ArticleMeta? article;
    Subtype? subtype;
    for (var a in uiData.articles) {
      if (a.id == articleId) {
        article = a;
        break;
      } else if (a.subtypes != null) {
        for (var s in a.subtypes!) {
          if (s.id == articleId) {
            subtype = s;
            break;
          }
        }
      }
    }

    if (article == null && subtype == null) {
      return ErrorScreen(errorMessage: _errorMessage);
    }

    final result = article?.result ?? subtype?.result;
    final sections = article?.sections ?? subtype?.sections;
    final title = article?.result?.title ?? subtype?.result.title;
    final unit = article?.unit ?? subtype?.unit;

    if (result == null || sections == null) {
      return ErrorScreen(errorMessage: _errorMessage);
    }

    // Determine current stage
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
              Text(
                getCurrentDateTime(),
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                uuid: widget.UUID,
              )
            ],
          ),
        ),
      ),
    );
  }
}
