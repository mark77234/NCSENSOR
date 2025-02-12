import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/storage/data/meta_storage.dart';
import 'package:NCSensor/widgets/screens/result/result_card.dart';
import 'package:flutter/material.dart';

import '../../models/data/result_model.dart';
import '../../models/meta/article_model.dart';
import '../../services/api_service.dart';
import '../../widgets/common/ncsAppBar.dart';
import '../../widgets/screens/result/action_button.dart';
import '../../widgets/screens/result/status_card.dart';

class ResultScreen extends StatefulWidget {
  final String articleId;
  final List<Map<String, dynamic>> sensors;

  const ResultScreen(
      {super.key, required this.articleId, required this.sensors});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  // late final ApiHook<List<BodyResultData>> resultApiHook;

  double? measuredValue;
  bool _isLoading = true;
  String? _errorMessage;
  BodyResultData? bodyResultData;

  ArticleMeta? article;

  @override
  void initState() {
    super.initState();
    _loadResultData();
  }

  Future<void> _loadData() async {
    final uiData = UiStorage.data;
    article = uiData.findArticleById(widget.articleId);

    if (article == null) {
      setState(() {
        _errorMessage = "결과를 찾을 수 없습니다";
      });
      return;
    }
  }

  Future<void> _loadResultData() async {
    try {
      await _loadData();
      if (_errorMessage != null) return; // 에러가 있으면 여기서 중단

      setState(() {
        _isLoading = true;
      });
      final response =
          await ApiService.getResultData(widget.articleId, widget.sensors);
      setState(() {
        bodyResultData = response;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Scaffold(
        appBar: const NCSAppBar(title: "결과"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: ColorStyles.primary,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(
                  fontSize: 18,
                  color: ColorStyles.primary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_isLoading) {
      return const Scaffold(
        appBar: NCSAppBar(title: "결과"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularProgressIndicator(
                strokeWidth: 8, // 두께 조절
                valueColor: AlwaysStoppedAnimation<Color>(ColorStyles.primary),
                backgroundColor: ColorStyles.lightgrey,
              ),
              Text(
                "결과 분석 중...",
                style: TextStyle(
                  fontFamily: "DoHyeon",
                  color: ColorStyles.primary,
                  fontSize: 30,
                ),
              )
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: NCSAppBar(title: "결과"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ResultCard(
                article: article!,
                result: bodyResultData!,
              ),
              StatusCard(
                sections: article!.sections,
                title: article!.result.title,
              ),
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
