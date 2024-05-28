import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF095D9E);
  static const Color primaryContainer = Color(0xFFA6CCED);
  static const Color secondary = Color(0xFF7CC8F8);
  static const Color secondaryContainer = Color(0xFFC5E7FF);
  static const Color tertiary = Color(0xFFDD520F);
  static const Color tertiaryContainer = Color(0xFFFFDBCD);
  static const Color error = Color(0xFFB00020);
  static const Color errorContainer = Color(0xFFFCD8DF);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFFf0f0f1);
  static const Color card = Color(0xFFebf1f7);
  static const Color iconColor = Color(0xff85898c);

  static const Color inputFill = Color(0xFFF6F6F6);
  static const Color inputStoke = Color(0xFFE8E8E8);

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1, 'shade values must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
      (darker ? (hsl.lightness - value) : (hsl.lightness + value))
          .clamp(0.0, 1.0),
    );

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    final colorShades = <int, Color>{
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color, //Primary value
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }
}
