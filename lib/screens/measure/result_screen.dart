import 'package:flutter/material.dart';
import 'package:taesung1/screens/measure/measure_screen.dart';
import '../../constants/styles.dart';
import '../splash/main_screen.dart';
import 'package:taesung1/services/api_service.dart';
import 'package:taesung1/models/result_model.dart';

class ResultScreen extends StatefulWidget {
  final String UUID;
  ResultScreen(this.UUID, {super.key});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  BodyResultData? bodyResultData;
  bool _isDataLoading = false;
  late String articleId = widget.UUID;
  Map<String, dynamic> sensors = {
    "s1": {"sensor_id": "UUID", "value": 0.0},
    "s2": {"sensor_id": "UUID", "value": 0.0},
    "s3": {"sensor_id": "UUID", "value": 0.0},
    "s4": {"sensor_id": "UUID", "value": 0.0},
  };

  @override
  void initState() {
    super.initState();
    _loadBodyResult(articleId, sensors);
  }

  Future<void> _loadBodyResult(String articleId, Map<String,dynamic> sensors) async {
    setState(() {
      _isDataLoading = true;
    });

    try {
      final data = await ApiService.getBodyData(articleId, sensors);
      setState(() {
        bodyResultData = data;
      });
    } catch(e) {
      print("오류: ${e}");
    }
    setState(() {
      _isDataLoading = false;
    });
  }

  String getCurrentDateTime() {
    final DateTime now = DateTime.now();
    final String period = now.hour >= 12 ? '오후' : '오전';
    final int hour = now.hour % 12;
    final int displayHour = hour == 0 ? 12 : hour;
    return '${now.year}.${now.month}.${now.day} $period $displayHour:${now.minute}';
  }

  @override
  Widget build(BuildContext context) {
    if (_isDataLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (bodyResultData == null) {
      return _buildEmptyState();
    } else {
      int stage = bodyResultData!.level.value;

      return Scaffold(
        appBar: AppBar(
          title: Text(
            bodyResultData!.title,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Center(
                      child: Text(
                        getCurrentDateTime(),
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildResultCard(stage),
                    const SizedBox(height: 20),
                    _buildStatusCard(),
                    const SizedBox(height: 20),
                    _buildActionButtons(context),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Card _buildResultCard(int stage) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: ColorStyles.grey, width: 0.5),
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
                      backgroundColor:
                          bodyResultData!.level.sections[stage].color,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      bodyResultData!.level.sections[stage].name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: bodyResultData!.level.sections[stage].color,
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
                  bodyResultData!.chart.result.value.toString(),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  bodyResultData!.chart.result.unit,
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
              value: bodyResultData!.chart.result.value /
                  bodyResultData!.chart.max,
              backgroundColor: const Color(0xFFF3F4F6),
              valueColor: AlwaysStoppedAnimation<Color>(
                  bodyResultData!.level.sections[stage].color),
            ),
            const SizedBox(height: 10),
            Text(
              bodyResultData!.comment,
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

  Card _buildStatusCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                bodyResultData!.level.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(bodyResultData!.level.sections.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor:
                                bodyResultData!.level.sections[index].color,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            bodyResultData!.level.sections[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4B5563),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        bodyResultData!.level.sections[index].content,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF4B5563),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MeasureScreen(widget.UUID),
              ),
            );
          },
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
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainScreen(),
              ),
            );
          },
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

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 48,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "데이터를 가져오는데 문제가 발생했습니다.",
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
}
