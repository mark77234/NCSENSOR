import 'package:flutter/material.dart';

import '../../constants/styles.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 8),
        Center(child: Text(title, style: TextStyles.title)),
        SizedBox(height: 16),
      ],
    );
  }
}
