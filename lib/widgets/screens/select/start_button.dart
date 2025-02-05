import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../../../screens/measure/measure_screen.dart';

class StartMeasurementButton extends StatelessWidget {
  final String selectedItem;
  final String selectedBodyParts;
  final String uuid;

  const StartMeasurementButton({
    super.key,
    required this.selectedItem,
    required this.selectedBodyParts,
    required this.uuid,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorStyles.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(400, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        if (selectedItem.isEmpty) {
          _showErrorDialog(context, '먼저 음주 또는 체취 항목을 선택하세요.');
        } else if (selectedItem == '체취' && selectedBodyParts.isEmpty) {
          _showErrorDialog(context, '체취 부위를 선택해 주세요.');
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MeasureScreen(uuid),
            ),
          );
        }
      },
      child: const Text(
        '항목 선택',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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