import 'package:flutter/material.dart';

class ColorStyles {
  static const Color primary = Color(0xFF3B82F6);
  static const Color secondary = Color(0xFF6B7280);
  static const Color grey = Color(0xFFF3F4F6);
  static const Color background = Color(0xFFF9FAFB);
  static const Color error = Color(0xFFEF4444);
}

class RadiusStyles {
  static const BorderRadius common = BorderRadius.all(Radius.circular(8));
  static const BorderRadius rounded = BorderRadius.all(Radius.circular(12));
}

class TextStyles {
  static const TextStyle title =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle subtitle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const TextStyle label =
      TextStyle(fontSize: 12, color: ColorStyles.secondary);
  static const TextStyle body = TextStyle(fontSize: 14, color: Colors.black);
}

class ButtonStyles {
  static ButtonStyle elevated = ElevatedButton.styleFrom(
    backgroundColor: ColorStyles.primary,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    minimumSize: const Size(double.infinity, 48),
    textStyle: TextStyles.subtitle,
    shape: RoundedRectangleBorder(
      borderRadius: RadiusStyles.common,
    ),
    iconColor: Colors.white,
  );

  static ButtonStyle outlined = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 16),
    foregroundColor: ColorStyles.primary,
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(
      borderRadius: RadiusStyles.common,
      side: BorderSide(
        color: ColorStyles.primary,
        width: 1.5,
      ),
    ),
    iconColor: ColorStyles.primary,
    textStyle: TextStyles.subtitle,
  );

  static ButtonStyle selectedElevated = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: RadiusStyles.rounded,
      side: BorderSide(
        color: ColorStyles.grey,
        width: 1.5,
      ),
    ),
    textStyle: const TextStyle(fontSize: 15),
  );

  static ButtonStyle defaultElevated = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: RadiusStyles.rounded,
      side: BorderSide(
        color: ColorStyles.primary,
        width: 1.5,
      ),
    ),
    textStyle: const TextStyle(fontSize: 15),
  );

  static ButtonStyle bodyOdorUnselected(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: RadiusStyles.rounded,
        side: BorderSide(
          color: ColorStyles.grey,
          width: 1.5,
        ),
      ),
    );
  }

  static ButtonStyle bodyOdorSelected(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      padding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: RadiusStyles.rounded,
        side: BorderSide(
          color: ColorStyles.primary,
          width: 1.5,
        ),
      ),
    );
  }
}

class InputStyles {
  static InputDecoration outlined = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: RadiusStyles.common,
      borderSide: BorderSide(color: ColorStyles.secondary, width: 1.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: RadiusStyles.common,
      borderSide: BorderSide(color: ColorStyles.secondary, width: 1.5),
    ),
    filled: true,
    fillColor: Colors.white,
    focusColor: ColorStyles.primary,
    focusedBorder: OutlineInputBorder(
      borderRadius: RadiusStyles.common,
      borderSide: BorderSide(color: ColorStyles.primary, width: 1.5),
    ),
    hoverColor: ColorStyles.primary,
    iconColor: ColorStyles.primary,
  );
}

class ContainerStyles {
  static BoxDecoration card = BoxDecoration(
    color: Colors.white,
    borderRadius: RadiusStyles.common,
    border: Border.all(color: ColorStyles.grey),
  );

  static BoxDecoration tile = BoxDecoration(
    color: ColorStyles.background,
    borderRadius: RadiusStyles.common,
  );

// static
}
