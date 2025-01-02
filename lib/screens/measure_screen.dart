import 'package:flutter/material.dart';
import '../constants/styles.dart';
import 'breath_screen.dart';

class MeasureScreen extends StatefulWidget {
  const MeasureScreen({super.key});

  @override
  State<MeasureScreen> createState() => _MeasureScreenState();
}

class _MeasureScreenState extends State<MeasureScreen> {
  bool showBodyOdorOptions = false; // 체취 버튼 클릭 여부
  String selectedMeasurement = ''; // 선택된 측정 항목
  String selectedBodyOdor = ''; // 선택된 체취 부위

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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedMeasurement == '음주'
                      ? ColorStyles.primary
                      : Colors.white,
                  foregroundColor: selectedMeasurement == '음주'
                      ? Colors.white
                      : Colors.black,
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: ColorStyles.primary,
                      width: 2,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    showBodyOdorOptions = false;
                    selectedMeasurement = '음주';
                    selectedBodyOdor = '';
                  });
                },
                child: const Text(
                  '음주',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedMeasurement == '체취'
                      ? ColorStyles.primary
                      : Colors.white,
                  foregroundColor: selectedMeasurement == '체취'
                      ? Colors.white
                      : Colors.black,
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: ColorStyles.primary,
                      width: 2,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    showBodyOdorOptions = !showBodyOdorOptions;
                    selectedMeasurement = '체취';
                    selectedBodyOdor = '';
                  });
                },
                child: const Text(
                  '체취',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 20),
              if (showBodyOdorOptions) ...[
                _buildBodyOdorButton('입', context),
                const SizedBox(height: 10),
                _buildBodyOdorButton('발', context),
                const SizedBox(height: 10),
                _buildBodyOdorButton('겨드랑이', context),
              ],
              const SizedBox(height: 200),
              Center(
                child: Text(
                  '항목을 선택하셨으면 측정시작 버튼을 눌러주세요',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFFB0B0B0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorStyles.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  // 측정 시작 버튼 클릭 시 동작
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
                  } else if (selectedMeasurement == '체취' && selectedBodyOdor.isEmpty) {
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
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 체취 부위 선택 버튼 빌드
  Widget _buildBodyOdorButton(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedBodyOdor == '$title 체취'
              ? ColorStyles.primary
              : Colors.white,
          foregroundColor: selectedBodyOdor == '$title 체취'
              ? Colors.white
              : Colors.black,
          minimumSize: const Size(280, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: ColorStyles.primary,
              width: 2,
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedBodyOdor = '$title 체취';
          });
        },
        child: Text(title),
      ),
    );
  }

  // 로딩 화면 다이얼로그 표시 및 화면 이동
  Future<void> _navigateWithLoading(BuildContext context) async {
    // 로딩 다이얼로그 표시
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
                  valueColor: AlwaysStoppedAnimation<Color>(ColorStyles.primary), // 로딩 인디케이터 색상
                ),
                const SizedBox(height: 20),
                Text(
                  "센서인식중...",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey, // 어두운 색상으로 가독성 높임
                    fontWeight: FontWeight.w600, // 글씨 두껍게 강조
                    letterSpacing: 1.2, // 글자 간격 추가
                    decoration: TextDecoration.none, // 밑줄 제거
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // 3초 대기 후, Breathscreen 페이지로 이동
    await Future.delayed(const Duration(seconds: 3));

    // 다이얼로그 닫기
    Navigator.pop(context);

    // Breathscreen 페이지로 이동
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