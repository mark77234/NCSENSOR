import 'dart:ui';

Color colorFromHex(String hexColor) {
  if (hexColor.length == 7 && hexColor.startsWith('#')) {
    return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
  } else {
    throw FormatException("Invalid color format: $hexColor");
  }
}
