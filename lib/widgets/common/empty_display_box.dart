import 'package:flutter/material.dart';

class EmptyDisplayBox extends StatelessWidget {
  const EmptyDisplayBox({super.key, this.icon, this.text});

  final IconData? icon;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.not_interested_rounded,
            size: 48,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            text ?? "데이터가 없습니다.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
