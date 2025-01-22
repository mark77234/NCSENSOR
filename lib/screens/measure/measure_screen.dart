import 'package:flutter/material.dart';
import '../../constants/styles.dart';
import 'result_screen.dart';

class MeasureScreen extends StatefulWidget {
  final String UUID;
  MeasureScreen(this.UUID, {super.key});

  @override
  State<MeasureScreen> createState() => _MeasureScreenState();
}

class _MeasureScreenState extends State<MeasureScreen> {
  bool _isLoading = false;
  double _progress = 0.0;
  String sensorStatus = "인식완료";
  Color sensorColor = ColorStyles.primary;

  @override
  void initState(){
    super.initState();
  }

  Future<void> _startMeasurement(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      setState(() {
        _progress = i / 100;
      });
      if (i == 100) {
        _navigateToResult(context);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _navigateToResult(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(widget.UUID),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: _progress,
                    strokeWidth: 18,
                    backgroundColor: const Color(0xFFF3F4F6),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.lerp(
                          Colors.green, ColorStyles.primary, _progress) ??
                          ColorStyles.primary,
                    ),
                  ),
                ),
                Text(
                  '${(_progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.lerp(
                        ColorStyles.grey, ColorStyles.primary, _progress) ??
                        ColorStyles.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 60,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: ColorStyles.grey,
                        width: 1,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "센서 상태",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: sensorColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                sensorStatus,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: sensorColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
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
                minimumSize: const Size(300, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                _isLoading ? "측정중..." : "측정하기",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}