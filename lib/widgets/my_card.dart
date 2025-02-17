import 'package:flutter/material.dart';

import '../constants/styles.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerStyles.card,
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.only(bottom: 12),
      child: child,
    );
  }
}
