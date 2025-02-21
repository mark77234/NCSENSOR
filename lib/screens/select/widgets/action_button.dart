import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../../measure/measure_screen.dart';

class ActionButton extends StatelessWidget {
  final String selectedItem;
  final String selectedBodyParts;
  final String uuid;

  const ActionButton({
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: Size(SizeStyles.getMediaWidth(context, 0.8), 60),
        shape: RoundedRectangleBorder(borderRadius: RadiusStyles.rounded),
      ),
      onPressed: () {
        if (selectedItem.isEmpty) {
          _showErrorDialog(context, '먼저 음주 또는 체취 항목을 선택하세요.');
        } else if (selectedItem == '체취' && selectedBodyParts.isEmpty) {
          _showErrorDialog(context, '체취 부위를 선택해 주세요.');
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeasureScreen(
                articleId: uuid,
              ),
            ),
          );
        }
      },
      child: const Text(
        '측정 하기',
        style: MeasureTextStyles.button,
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
