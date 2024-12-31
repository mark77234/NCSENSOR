import 'package:flutter/material.dart';
import 'Breath.dart'; // Breath.dart를 임포트

class Measure extends StatefulWidget {
  const Measure({super.key});

  @override
  State<Measure> createState() => _MeasureState();
}

class _MeasureState extends State<Measure> {
  bool showBodyOdorOptions = false; // 체취 버튼 클릭 여부
  String selectedMeasurement = ''; // 선택된 측정 항목
  String selectedBodyOdor = ''; // 선택된 체취 부위

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("측정"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedMeasurement == '음주'
                        ? Colors.grey
                        : const Color(0xFF001F54),
                    foregroundColor: selectedMeasurement == '음주'
                        ? Colors.black
                        : Colors.white,
                  ),
                  onPressed: () {
                    // 음주 버튼 클릭 시 동작
                    setState(() {
                      showBodyOdorOptions = false; // 체취 버튼 숨김
                      selectedMeasurement = '음주';
                      selectedBodyOdor = ''; // 체취 부위 초기화
                    });
                  },
                  child: const Text('음주'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedMeasurement == '체취'
                        ? Colors.grey
                        : const Color(0xFF001F54),
                    foregroundColor: selectedMeasurement == '체취'
                        ? Colors.black
                        : Colors.white,
                  ),
                  onPressed: () {
                    // 체취 버튼 클릭 시 동작
                    setState(() {
                      showBodyOdorOptions = !showBodyOdorOptions;
                      selectedMeasurement = '체취';
                      selectedBodyOdor = ''; // 체취 부위 초기화
                    });
                  },
                  child: const Text('체취'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (showBodyOdorOptions) ...[
              const SizedBox(height: 20),
              _buildBodyOdorButton('입', context),
              const SizedBox(height: 10),
              _buildBodyOdorButton('발', context),
              const SizedBox(height: 10),
              _buildBodyOdorButton('겨드랑이', context),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001F54),
                foregroundColor: Colors.white,
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                // 통합 측정 시작 버튼 동작
                if (selectedMeasurement.isEmpty) {
                  // 측정 항목이 선택되지 않았을 경우 알림
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
                  // 체취 항목을 선택했지만, 부위가 선택되지 않았을 경우 알림
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
                  // 바로 Breath 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Breath(
                          measurement: selectedMeasurement,
                          bodymeasurement: selectedBodyOdor),
                    ),
                  );
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
    );
  }

  Widget _buildBodyOdorButton(String title, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedBodyOdor == '$title 체취'
            ? Colors.grey
            : const Color(0xFF001F54),
        foregroundColor: selectedBodyOdor == '$title 체취'
            ? Colors.black
            : Colors.white,
      ),
      onPressed: () {
        setState(() {
          selectedBodyOdor = '$title 체취';
        });
      },
      child: Text(title),
    );
  }
}