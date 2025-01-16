import 'dart:ui';

import '../utils/util.dart';

class BodyResultData {
  final int level;
  final String name;
  final String content;
  final Color color;

  BodyResultData({
    required this.level,
    required this.name,
    required this.content,
    required this.color,
  });

  factory BodyResultData.fromJson(Map<String, dynamic> json) {
    return BodyResultData(
      level: json['level'],
      name: json['name'],
      content: json['content'],
      color: colorFromHex(json['color']),
    );
  }
}
