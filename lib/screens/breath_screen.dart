import 'package:flutter/material.dart';
import '../constants/styles.dart';
import 'alcohol_result_screen.dart';
import 'body_result_screen.dart';

class BreathScreen extends StatefulWidget {
  final String measurement;
  final String bodymeasurement;

  const BreathScreen({
    super.key,
    required this.measurement,
    required this.bodymeasurement,
  });

  @override
  _BreathScreenState createState() => _BreathScreenState();
}

class _BreathScreenState extends State<BreathScreen> {
  bool _isLoading = false;
  double _progress = 0.0;

  Future<void> _startMeasurement(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      setState(() {
        _progress = i / 100;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _navigateToResult(BuildContext context) {
    if (widget.measurement == "음주") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AlcoholResultScreen()),
      );
    } else if (widget.measurement == "체취") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BodyResultScreen(measurement: widget.bodymeasurement),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String measurementStatus = _progress == 0
        ? '측정전'
        : _progress < 1.0
            ? '측정중'
            : '측정완료';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "농도 측정",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: _progress,
                    strokeWidth: 18,
                    backgroundColor: Color(0xFFF3F4F6),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.lerp(Colors.green, ColorStyles.primary, _progress) ??
                          ColorStyles.primary, // null 처리
                    ),
                  ),
                ),
                Text(
                  '${(_progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.lerp(ColorStyles.grey, ColorStyles.primary, _progress) ??
                        ColorStyles.primary, // null 처리
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 센서 상태 카드 (가로로 배치)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 320,
                    height: 80,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // 모서리 둥글게 설정
                        side: BorderSide(
                          color: ColorStyles.grey, // 가장자리를 회색으로 설정
                          width: 1, // 가장자리 두께 설정
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      elevation: 0,
                      // 그림자 효과 제거
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "센서 상태",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 100),
                            Container(
                              padding: const EdgeInsets.all(5),
                              // 더 큰 원형 모양으로 만들기 위해 패딩을 늘림
                              decoration: BoxDecoration(
                                color: _progress == 0
                                    ? Colors.grey
                                    : _progress < 1.0
                                        ? Colors.yellow
                                        : Colors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(
                              measurementStatus,
                              style: TextStyle(
                                fontSize: 18,
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
            const SizedBox(height: 70),

            // 버튼: 측정하기 / 결과 보러가기
            ElevatedButton(
              onPressed: _progress < 1.0
                  ? () => _startMeasurement(context)
                  : () => _navigateToResult(context),
              style: ElevatedButton.styleFrom(
                foregroundColor: _progress < 1.0
                    ? (_isLoading ? Colors.grey : Colors.white)
                    : Colors.white,
                backgroundColor: _progress < 1.0
                    ? (_isLoading ? ColorStyles.grey : ColorStyles.primary)
                    : ColorStyles.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                fixedSize: Size(320, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // 모서리 둥글게 설정
                ),
              ),
              child: Text(
                _progress < 1.0 ? (_isLoading ? "측정중..." : "측정하기") : "결과 보러가기",
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
