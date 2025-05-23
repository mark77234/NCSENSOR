import 'package:flutter/material.dart';

class ColorStyles {
  static const Color primary = Color(0xFF3B82F6);
  static const Color secondary = Color(0xFF6B7280);
  static const Color lightgrey = Color(0xFFF3F4F6);
  static const Color darkgrey = Color(0xFF8A8E8E);
  static const Color background = Color(0xFFF9FAFB);
  static const Color error = Color(0xFFEF4444);
}

class RadiusStyles {
  static const BorderRadius common = BorderRadius.all(Radius.circular(8));
  static const BorderRadius rounded = BorderRadius.all(Radius.circular(12));
  static const BorderRadius largeRadius = BorderRadius.all(Radius.circular(30));
}

class TextStyles {
  static const TextStyle apptitle = TextStyle(
    fontSize: 50,
    color: Color(0xFF3B82F6),
    fontFamily: 'DoHyeon',
    fontWeight: FontWeight.w600,
  );
  static const TextStyle title =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle subtitle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, fontFamily: "DoHyeon");
  static const TextStyle label =
      TextStyle(fontSize: 12, color: ColorStyles.secondary);
  static const TextStyle body = TextStyle(fontSize: 14, color: Colors.black);
  static const TextStyle progressPercentage = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );
}

class MeasureTextStyles {
  static const TextStyle main = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle sub =
      TextStyle(fontSize: 10, color: ColorStyles.darkgrey);
  static const TextStyle button = TextStyle(
    // 클릭 시 드롭박스 제목
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w900,
  );
}

class ButtonStyles {
  static ButtonStyle primaryExpandElevated = ElevatedButton.styleFrom(
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

  static ButtonStyle primaryExpandOutlined = ElevatedButton.styleFrom(
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

  static ButtonStyle greyOutlined = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: BorderSide(
        color: ColorStyles.lightgrey,
        width: 1.5,
      ),
    ),
    textStyle: const TextStyle(fontSize: 15),
  );

  static ButtonStyle primaryOutlined = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side: BorderSide(
        color: ColorStyles.primary,
        width: 1.5,
      ),
    ),
    textStyle: const TextStyle(fontSize: 15),
  );
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
    border: Border.all(color: ColorStyles.lightgrey),
  );

  static BoxDecoration tile = BoxDecoration(
    color: ColorStyles.background,
    borderRadius: RadiusStyles.common,
  );
  static BoxDecoration block = BoxDecoration(
    color: ColorStyles.lightgrey,
    borderRadius: RadiusStyles.largeRadius,
  );

// static
}

class SizeStyles {
  static double getMediaWidth(BuildContext context, double ratio) {
    return MediaQuery.of(context).size.width * ratio;
  }

  static double getMediaHeight(BuildContext context, double ratio) {
    return MediaQuery.of(context).size.height * ratio;
  }
}
