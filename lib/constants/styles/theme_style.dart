import 'package:opmswebstaff/constants/font_name/font_name.dart';
import 'package:opmswebstaff/constants/styles/button_style.dart';
import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';

import 'palette_color.dart';

class ThemeStyles {
  ThemeStyles._();

  static ThemeData themeLight = ThemeData(
    fontFamily: FontNames.sfPro,
    appBarTheme: AppBarTheme(
      backgroundColor: Palettes.kcBlueMain1,
      elevation: 0,
    ),
    backgroundColor: Color(0xcb4987f5),
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Palettes.kcBlueMain1,
      primarySwatch: primaryColorSwatch,
      primaryColorDark: primaryColorSwatch[900],
    ),
    splashColor: Palettes.kcBlueMain1.withOpacity(0.2),
    hintColor: Palettes.kcHintColor,
    dividerColor: Palettes.kcHintColor,
    textTheme: TextTheme(bodyText2: TextStyles.tsBody2()),
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ButtonStyles.elevatedButtonThemeDataLight,
    outlinedButtonTheme: ButtonStyles.outlinedButtonThemeDataLight,
  );
}

final mainColor = 0xff0065FF;
final MaterialColor primaryColorSwatch = MaterialColor(mainColor, <int, Color>{
  50: Color(0xFF80b2ff),
  100: Color(0xFF66a3ff),
  200: Color(0xFF4d93ff),
  300: Color(0xFF3384ff),
  400: Color(0xFF1a74ff),
  500: Color(mainColor),
  600: Color(0xFF005be6),
  700: Color(0xFF0051cc),
  800: Color(0xFF0047b3),
  900: Color(0xff0F3D91),
});
