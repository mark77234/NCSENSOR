// 재사용 가능한 텍스트 입력 위젯
import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/widgets/common/my_field.dart';
import 'package:NCSensor/widgets/common/sm_tile.dart';
import 'package:flutter/material.dart';

class EditableField extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditing;
  final Function(String) onChanged;
  final TextInputType keyboardType;

  const EditableField({
    super.key,
    required this.label,
    required this.value,
    required this.isEditing,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return MyField(
      label: label,
      widget: isEditing
          ? TextField(
              onChanged: onChanged,
              decoration: InputStyles.outlined,
              keyboardType: keyboardType,
              controller: TextEditingController(text: value),
            )
          : SmTile(title: value),
    );
  }
}
