import 'dart:ui';

import 'package:NCSensor/constants/styles.dart';

Color colorFromHex(String hexColor) {
  try {
    if (hexColor.length == 7 && hexColor.startsWith('#')) {
      return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
    } else if (hexColor.length == 9 && hexColor.startsWith('#')) {
      return Color(int.parse(hexColor.substring(1), radix: 16));
    } else {
      throw FormatException("Invalid color format: $hexColor");
    }
  } catch (e) {
    return ColorStyles.primary;
  }
}

String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}
