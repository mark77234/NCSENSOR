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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                        ? ButtonStyles.defaultElevated(context)
                        : ButtonStyles.selectedElevated(context),
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
                          children: [
                            SvgPicture.asset(
                              'assets/drinking.svg',
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '음주',
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '혈중 알코올\n농도 측정',
                                  style: TextStyle(
                                    fontSize: width * 0.03,
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
                        ? ButtonStyles.defaultElevated(context)
                        : ButtonStyles.selectedElevated(context),
                    onPressed: () {
                      setState(() {
                        showBodyOdorOptions = !showBodyOdorOptions;
                        selectedMeasurement = '체취';
                        selectedBodyOdor = '';
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/body.svg',
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '체취',
                                  style: TextStyle(
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '부위별 악취\n농도 측정',
                                  style: TextStyle(
                                    fontSize: width * 0.03,
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
                      fontSize: width * 0.04,
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
                  minimumSize: Size(width * 0.65, height * 0.08),
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
    String iconPath = '';
    switch (title) {
      case '입':
        iconPath = 'assets/mouth.svg';
        break;
      case '발':
        iconPath = 'assets/foot.svg';
        break;
      case '겨드랑이':
        iconPath = 'assets/armpit.svg';
        break;
    }

    return ElevatedButton(
      style: selectedBodyOdor == '$title 체취'
          ? ButtonStyles.bodyOdorSelected(context)
          : ButtonStyles.bodyOdorUnselected(context),
      onPressed: () {
        setState(() {
          selectedBodyOdor = '$title 체취';
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 12,),
          Column(
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
        ],
      ),
    );
  }

  String _getBodyOdorDescription(String bodyPart) {
    switch (bodyPart) {
      case '입':
        return '입에서 나는 구취 측정';
      case '발':
        return '발에서 나는 악취 측정';
      case '겨드랑이':
        return '겨드랑이에서 나는 악취를 측정';
      default:
        return '';
    }
  }

  Future<void> _navigateWithLoading(BuildContext context) async {

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
