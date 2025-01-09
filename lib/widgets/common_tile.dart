import 'package:flutter/material.dart';
import 'package:taesung1/constants/styles.dart';

class CommonTile extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final IconData? actionIcon;
  final void Function()? onAction;

  const CommonTile({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.actionIcon,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: ColorStyles.secondary),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: ContainerStyles.tile,
          child: Row(
            children: [
              Column(
                children: [
                  Text(title),
                  if (subtitle != null) Text(subtitle!),
                ],
              ),
              if (actionIcon != null && onAction != null)
                IconButton(
                  icon: Icon(actionIcon),
                  onPressed: onAction!,
                  color: ColorStyles.error,
                ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
