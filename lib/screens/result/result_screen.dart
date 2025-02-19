import 'package:NCSensor/screens/result/widgets/result_card.dart';
import 'package:NCSensor/storage/data/meta_storage.dart';
import 'package:NCSensor/widgets/error_screen.dart';
import 'package:flutter/material.dart';

import '../../models/data/result_model.dart';
import '../../models/meta/article_model.dart';
import '../../models/meta/ncs_meta.dart';
import '../../services/api_service.dart';
import '../../utils/api_hook.dart';
import '../../widgets/api_state_builder.dart';
import '../../widgets/ncs_app_bar.dart';
import 'widgets/action_button.dart';
import 'widgets/status_card.dart';

class ResultScreen extends StatefulWidget {
  final String articleId;
  final List<Map<String, dynamic>> sensors;

  const ResultScreen(
      {super.key, required this.articleId, required this.sensors});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late final ApiHook<BodyResultData> resultApiHook;
  final NcsMetaData metaData = UiStorage.data;

  bool metaLoaded = false;
  BodyResultData? bodyResultData;

  ArticleMeta? article;

  @override
  void initState() {
    super.initState();
    _loadArticleMeta();
    resultApiHook = ApiHook(
        apiCall: () => ApiService.getResultData(
              widget.articleId,
              widget.sensors,
            ));
    resultApiHook.addListener(() {
      setState(() {});
    });
  }

  _loadArticleMeta() async {
    setState(() {
      article = metaData.findArticleById(widget.articleId);
      metaLoaded = !(article == null);
    });
  }

  @override
  void dispose() {
    resultApiHook.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!metaLoaded) return ErrorScreen(errorMessage: "메타데이터 인식실패");
    return Scaffold(
      appBar: NCSAppBar(title: "결과"),
      body: Center(
        child: ApiStateBuilder(
            apiState: resultApiHook.state,
            title: "결과",
            loadingText: "결과 분석 중...",
            builder: (context, data) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ResultCard(
                          article: article!,
                          result: data,
                        ),
                        StatusCard(
                          sections: article!.sections,
                          title: article!.result.title,
                        ),
                      ],
                    ),
                    ActionButton(
                      context: context,
                      uuid: widget.articleId,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
