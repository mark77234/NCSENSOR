import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/styles.dart';
import '../../providers/ui_data_provider.dart';
import '../splash/main_screen.dart';
import 'package:NCSensor/screens/measure/measure_screen.dart';
import 'package:NCSensor/models/ui_model.dart';

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

  @override
  void initState() {
    super.initState();
    articleId = widget.UUID;
    _loadData();
  }

  void _loadData() async {
    try {
      // Simulated measured value - replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        measuredValue = 0.015; // Example value for demonstration
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
    final uiDataProvider = Provider.of<UiDataProvider>(context);
    final uiData = uiDataProvider.uiData;

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return _buildErrorState();
    }

    if (uiData == null || measuredValue == null) {
      return _buildErrorState();
    }

    // Find matching article or subtype
    Article? article;
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
      return _buildErrorState();
    }

    final result = article?.result ?? subtype?.result;
    final sections = article?.sections ?? subtype?.sections;
    final title = article?.name ?? subtype?.name;
    final unit = article?.unit ?? subtype?.unit;

    if (result == null || sections == null) {
      return _buildErrorState();
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
              _buildResultCard(stage, result, sections, measuredValue!, unit),
              const SizedBox(height: 20),
              _buildStatusCard(sections, title),
              const SizedBox(height: 20),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(
      int stage, Result result, List<Section> sections, double value, String? unit) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: ColorStyles.lightgrey, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '현재 상태',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: sections[stage].color,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      sections[stage].name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: sections[stage].color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.toStringAsFixed(3),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  unit ?? '',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: value / result.max,
              backgroundColor: const Color(0xFFF3F4F6),
              valueColor: AlwaysStoppedAnimation<Color>(sections[stage].color),
            ),
            const SizedBox(height: 10),
            Text(
              sections[stage].content,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(List<Section> sections, String title) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(
                sections.length,
                    (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: sections[index].color,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            sections[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4B5563),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        sections[index].content,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4B5563),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MeasureScreen(widget.UUID),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: ColorStyles.primary),
            fixedSize: const Size(150, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            '다시측정',
            style: TextStyle(
              color: ColorStyles.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorStyles.primary,
            fixedSize: const Size(150, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text(
            '확인',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 48,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? "데이터를 찾을 수 없습니다.",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}