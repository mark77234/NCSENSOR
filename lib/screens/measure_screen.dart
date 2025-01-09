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
            // Row에서 Column으로 변경하여 세로로 정렬
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Row(
                // 음주와 체취 버튼을 Row로 나란히 배치
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
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '음주\n', // 첫 번째 줄 텍스트 (음주)
                            style: TextStyle(
                              fontSize: 16, // 첫 번째 줄 텍스트 스타일
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                          TextSpan(
                            text: '알코올 농도 측정', // 두 번째 줄 텍스트 (알코올농도 측정)
                            style: TextStyle(
                              fontSize: 14, // 두 번째 줄 텍스트 스타일
                              color: Colors.grey, // 색상 설정 (옵션)
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center, // 텍스트 정렬을 중앙으로 설정
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
                            text: '체취\n', // 첫 번째 줄 텍스트 (음주)
                            style: TextStyle(
                              fontSize: 16, // 첫 번째 줄 텍스트 스타일
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                          TextSpan(
                            text: '부위별 악취 측정', // 두 번째 줄 텍스트 (알코올농도 측정)
                            style: TextStyle(
                              fontSize: 14, // 두 번째 줄 텍스트 스타일
                              color: Colors.grey, // 색상 설정 (옵션)
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center, // 텍스트 정렬을 중앙으로 설정
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

  // 체취 부위 선택 버튼 빌드
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
            _getBodyOdorDescription(title), // Show the description text
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey, // You can change this color as needed
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

// Add a method to provide descriptions for each body part
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
                  valueColor: AlwaysStoppedAnimation<Color>(
                      ColorStyles.primary), // 로딩 인디케이터 색상
                ),
                const SizedBox(height: 20),
                Text(
                  "센서인식중...",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    // 어두운 색상으로 가독성 높임
                    fontWeight: FontWeight.w600,
                    // 글씨 두껍게 강조
                    letterSpacing: 1.2,
                    // 글자 간격 추가
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
