import 'package:flutter/material.dart';
import 'package:NCSensor/constants/styles.dart';

class MyField extends StatelessWidget {
  final String label;
  final Widget widget;

  const MyField({
    super.key,
    required this.label,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyles.label,
        ),
        SizedBox(height: 12),
        widget,
        SizedBox(height: 20),
      ],
    );
  }
}
