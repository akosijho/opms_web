import 'package:opmswebstaff/constants/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'palette_color.dart';

class ButtonStyles {
  ButtonStyles._();

  static ElevatedButtonThemeData elevatedButtonThemeDataLight =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 1,
      primary: Palettes.kcPurpleMain,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: TextStyle(
        fontSize: kfsButton1.sp,
        letterSpacing: 0.5,
      ),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonThemeDataLight =
      OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      textStyle: TextStyle(
        fontSize: kfsButton1.sp,
        letterSpacing: 0.5,
      ),
      primary: Palettes.kcPurpleMain,
      side: BorderSide(color: Palettes.kcPurpleMain, width: 1),
    ),
  );

  static ButtonStyle whiteButtonStyle({bool? isBold}) => TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        primary: Palettes.kcPurpleMain,
        textStyle: TextStyle(
          fontWeight:
              isBold != null && isBold ? FontWeight.w600 : FontWeight.normal,
          fontSize: kfsBody1.sp,
          letterSpacing: 0.5,
        ),
      );
}
