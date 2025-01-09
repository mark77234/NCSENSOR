import 'package:flutter/material.dart';
import 'package:taesung1/constants/styles.dart';

class MyTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? actionIcon;
  final void Function()? onAction;

  const MyTile({
    super.key,
    required this.title,
    this.subtitle,
    this.actionIcon,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: ContainerStyles.tile,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyles.label,
                ),
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
    );
  }
}
