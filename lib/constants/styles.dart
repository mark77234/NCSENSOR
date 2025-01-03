import 'package:flutter/material.dart';

class ColorStyles {
  static const Color primary = Color(0xFF3B82F6);
  static const Color secondary = Color(0xFF4B5563);
  static const Color grey = Color(0xFFD1D5DB);
  static const Color background = Color(0xFFFFFFFF);
}

class RadiusStyles {
  static const BorderRadius border = BorderRadius.all(Radius.circular(8));
}

class TextStyles {
  static const TextStyle title = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: ColorStyles.primary);
  static const TextStyle subtitle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const TextStyle body = TextStyle(fontSize: 14, color: Colors.black);
}

class ButtonStyles {
  static ButtonStyle elevated = ElevatedButton.styleFrom(
    backgroundColor: ColorStyles.primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    minimumSize: const Size(double.infinity, 48),
    textStyle:  TextStyles.subtitle,
    shape: RoundedRectangleBorder(
      borderRadius: RadiusStyles.border,
    ),
  );
  static ButtonStyle outlined = OutlinedButton.styleFrom(
    side: const BorderSide(color: ColorStyles.primary, width: 2),
    padding: const EdgeInsets.symmetric(vertical: 16),
    minimumSize: const Size(double.infinity, 48),
    textStyle:  TextStyles.subtitle,
    shape: RoundedRectangleBorder(
      borderRadius: RadiusStyles.border,
    ),
  );
}

class InputStyles {
  static InputDecoration outlined = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: RadiusStyles.border,
      borderSide: BorderSide(color: ColorStyles.primary, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: RadiusStyles.border,
      borderSide: BorderSide(color: ColorStyles.primary, width: 2),
    ),
    filled: true,
    fillColor: Colors.white,
  );
}
