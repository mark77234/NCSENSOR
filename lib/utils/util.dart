import 'dart:ui';

Color colorFromHex(String hexColor) {
  if (hexColor.length == 7 && hexColor.startsWith('#')) {
    return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
  } else if (hexColor.length == 9 && hexColor.startsWith('#')) {
    return Color(int.parse(hexColor.substring(1), radix: 16));
  } else {
    throw FormatException("Invalid color format: $hexColor");
  }
}

String colorToHex(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
}