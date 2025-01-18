import 'package:flutter/material.dart';
import '../constants/styles.dart';
import 'breath_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taesung1/services/api_service.dart';
import 'package:taesung1/models/aritcle_model.dart';

class MeasureScreen extends StatefulWidget {
  const MeasureScreen({super.key});

  @override
  State<MeasureScreen> createState() => _MeasureScreenState();
}

class _MeasureScreenState extends State<MeasureScreen> {
  bool showBodyOdorOptions = false;
  String selectedMeasurement = '';
  String selectedBodyOdor = '';

  ArticleData? articledata;

  bool _isLabelLoading = false;

  @override
  void initState() {
    super.initState();
    _loadArticleData();
  }

  Future<void> _loadArticleData() async {
    setState(() {
      _isLabelLoading = true;
    });
    try {
      final data = await ApiService.getArticleData();
      setState(() {
        articledata = data;
      });
    } catch (e) {
      print('Error loading measure labels: $e');
    }
    setState(() {
      _isLabelLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (_isLabelLoading)
                CircularProgressIndicator()
              else
                Column(
                  children: [
                    const SizedBox(height: 50),
                    _buildMeasurementButtons(),
                    if (showBodyOdorOptions) _buildBodyOdorSelection(),
                    const SizedBox(height: 50),
                    _buildStartMeasurementButton(context),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildMeasurementButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildMeasurementButton(articledata!.articles[0].name, '혈중 알코올\n농도 측정', 'assets/drinking.svg'),
        const SizedBox(width: 20),
        _buildMeasurementButton(articledata!.articles[1].name, '부위별 악취\n농도 측정', 'assets/body.svg'),
      ],
    );
  }

  ElevatedButton _buildMeasurementButton(
      String measurement, String description, String assetPath) {
    return ElevatedButton(
      style: selectedMeasurement == measurement
          ? ButtonStyles.defaultElevated(context)
          : ButtonStyles.selectedElevated(context),
      onPressed: () {
        setState(() {
          showBodyOdorOptions = measurement == '체취';
          selectedMeasurement = measurement;
          selectedBodyOdor = '';
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                assetPath,
                height: 40,
                width: 40,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    measurement,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBodyOdorSelection() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Center(
          child: Text(
            "측정 부위를 선택해주세요",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(height: 30),
        _buildBodyOdorButton(articledata!.articles[1].subtypes![0].name),
        const SizedBox(height: 10),
        _buildBodyOdorButton(articledata!.articles[1].subtypes![1].name),
        const SizedBox(height: 10),
        _buildBodyOdorButton(articledata!.articles[1].subtypes![2].name),
      ],
    );
  }

  ElevatedButton _buildBodyOdorButton(String title) {
    String iconPath = _getBodyOdorIconPath(title);

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
          const SizedBox(width: 12),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                _getBodyOdorDescription(title),
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getBodyOdorIconPath(String bodyPart) {
    switch (bodyPart) {
      case '입':
        return 'assets/mouth.svg';
      case '발':
        return 'assets/foot.svg';
      case '겨드랑이':
        return 'assets/armpit.svg';
      default:
        return '';
    }
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

  ElevatedButton _buildStartMeasurementButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorStyles.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(300, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () async {
        if (selectedMeasurement.isEmpty) {
          _showErrorDialog(context, '먼저 음주 또는 체취 항목을 선택하세요.');
        } else if (selectedMeasurement == '체취' && selectedBodyOdor.isEmpty) {
          _showErrorDialog(context, '체취 부위를 선택해 주세요.');
        } else {
          _navigateWithLoading(context);
        }
      },
      child: const Text(
        '측정 시작',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _navigateWithLoading(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BreathScreen(),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('오류'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
