// 재사용 가능한 텍스트 입력 위젯
import 'package:flutter/material.dart';

import '../constants/styles.dart';

class EditableField extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditing;
  final Function(String) onChanged;

  const EditableField({
    super.key,
    required this.label,
    required this.value,
    required this.isEditing,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: ColorStyles.secondary)),
          SizedBox(height: 8),
          TextField(
              controller: TextEditingController(text: value),
              onChanged: onChanged,
              enabled: isEditing,
              style: TextStyles.body,
              decoration: InputStyles.outlined
          ),
        ],
      ),
    );
  }
}
