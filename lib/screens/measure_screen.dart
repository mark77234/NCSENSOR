import 'package:flutter/material.dart';
import '../constants/styles.dart';
import 'breath_screen.dart';
import 'package:flutter_svg/svg.dart';

class MeasureScreen extends StatefulWidget {
  const MeasureScreen({super.key});

  @override
  State<MeasureScreen> createState() => _MeasureScreenState();
}

class _MeasureScreenState extends State<MeasureScreen> {
  bool showBodyOdorOptions = false;
  String selectedMeasurement = '';
  String selectedBodyOdor = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: selectedMeasurement == '음주'
                        ? ButtonStyles.defaultElevated
                        : ButtonStyles.selectedElevated,
                    onPressed: () {
                      setState(() {
                        showBodyOdorOptions = false;
                        selectedMeasurement = '음주';
                        selectedBodyOdor = '';
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/drinking.svg', // drinking.svg의 경로
                              height: 40, // 원하는 크기로 조정
                              width: 40,
                            ),
                            const SizedBox(width: 12), // 아이콘과 텍스트 사이 간격
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '음주',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '혈중 알코올\n농도 측정',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: selectedMeasurement == '체취'
                        ? ButtonStyles.defaultElevated
                        : ButtonStyles.selectedElevated,
                    onPressed: () {
                      setState(() {
                        showBodyOdorOptions = !showBodyOdorOptions;
                        selectedMeasurement = '체취';
                        selectedBodyOdor = '';
                      });
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '체취\n',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                          TextSpan(
                            text: '부위별 악취 측정',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              if (showBodyOdorOptions) ...[
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    "측정 부위를 선택해주세요",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _buildBodyOdorButton('입', context),
                const SizedBox(height: 10),
                _buildBodyOdorButton('발', context),
                const SizedBox(height: 10),
                _buildBodyOdorButton('겨드랑이', context),
              ],
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyles.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(320, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () async {
                  if (selectedMeasurement.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('오류'),
                        content: const Text('먼저 음주 또는 체취 항목을 선택하세요.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('확인'),
                          ),
                        ],
                      ),
                    );
                  } else if (selectedMeasurement == '체취' &&
                      selectedBodyOdor.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('오류'),
                        content: const Text('체취 부위를 선택해 주세요.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('확인'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    _navigateWithLoading(context);
                  }
                },
                child: const Text(
                  '측정 시작',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBodyOdorButton(String title, BuildContext context) {
    return ElevatedButton(
      style: selectedBodyOdor == '$title 체취'
          ? ButtonStyles.bodyOdorSelected
          : ButtonStyles.bodyOdorUnselected,
      onPressed: () {
        setState(() {
          selectedBodyOdor = '$title 체취';
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            _getBodyOdorDescription(title),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getBodyOdorDescription(String bodyPart) {
    switch (bodyPart) {
      case '입':
        return '구강 냄새 측정';
      case '발':
        return '발에서 나는 악취를 측정';
      case '겨드랑이':
        return '겨드랑이에서 나는 악취를 측정';
      default:
        return '';
    }
  }

  Future<void> _navigateWithLoading(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(ColorStyles.primary),
                ),
                const SizedBox(height: 20),
                Text(
                  "센서인식중...",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    await Future.delayed(const Duration(seconds: 3));

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BreathScreen(
          measurement: selectedMeasurement,
          bodymeasurement: selectedBodyOdor,
        ),
      ),
    );
  }
}