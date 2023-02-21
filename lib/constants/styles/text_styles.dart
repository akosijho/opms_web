import 'package:opmsapp/constants/font_name/font_name.dart';
import 'package:opmsapp/constants/styles/palette_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Screen Size
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

//FONT SIZES
const kfsHeading1 = 38.0;
const kfsHeading0 = 32.0;
const kfsHeading2 = 28.0;
const kfsHeading3 = 23.0;
const kfsHeading4 = 15.0;
const kfsHeading5 = 14.0;
const kfsButton1 = 15.0;
const kfsButton2 = 13.0;
const kfsCaption1 = 12.0;
const kfsCaption2 = 11.0;
const kfsBody1 = 18.0;
const kfsBody2 = 14.0;
const kfsBody3 = 13.0;
const kfsSmall = 12.0;

//TEXT STYLES
class TextStyles {
  static TextStyle tsHeading1({Color? color}) => TextStyle(
      fontFamily: FontNames.gilRoy,
      fontWeight: FontWeight.w600,
      fontSize: kfsHeading1.sp,
      color: color ?? Colors.black);

  static TextStyle tsHeading2({Color? color}) => TextStyle(
      fontFamily: FontNames.gilRoy,
      fontWeight: FontWeight.w600,
      fontSize: kfsHeading2.sp,
      color: color ?? Colors.black);

  static TextStyle tsHeading3({Color? color}) => TextStyle(
      fontFamily: FontNames.gilRoy,
      fontWeight: FontWeight.w600,
      fontSize: kfsHeading3.sp,
      color: color ?? Colors.black);

  static TextStyle tsHeading4({Color? color}) => TextStyle(
      fontFamily: FontNames.gilRoy,
      fontWeight: FontWeight.w600,
      fontSize: kfsHeading4.sp,
      color: color ?? Colors.black);

  static TextStyle tsHeading5({Color? color}) => TextStyle(
      fontFamily: FontNames.gilRoy,
      fontWeight: FontWeight.w600,
      fontSize: kfsHeading5.sp,
      color: color ?? Colors.black);

  static TextStyle tsButton1({Color? color}) => TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: kfsButton1.sp,
      color: color ?? Colors.black);

  static TextStyle tsButton2({Color? color}) => TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: kfsButton2.sp,
      color: color ?? Colors.black);

  static TextStyle tsCaption1({Color? color}) => TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: kfsCaption1.sp,
      color: color ?? Colors.black);

  static TextStyle tsCaption2({Color? color}) => TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: kfsCaption2.sp,
      color: color ?? Colors.black);

  static TextStyle tsBody1({Color? color}) => TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: kfsBody1.sp,
      letterSpacing: 0.5,
      color: color ?? Colors.black);

  static TextStyle tsBody2({Color? color}) => TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: kfsBody2.sp,
      letterSpacing: 0.5,
      color: color ?? Colors.black);

  static TextStyle tsBody3({Color? color}) => TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: kfsBody3.sp,
      letterSpacing: 0.5,
      color: color ?? Colors.black);

  static TextStyle tsBody4({Color? color}) => TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: kfsSmall.sp,
      letterSpacing: 0.5,
      color: color ?? Colors.black);

  static TextStyle ktsHintTextStyle = TextStyle(
      fontFamily: FontNames.gilRoy,
      fontSize: kfsBody2.sp,
      color: Palettes.kcHintColor);

  static const errorTextStyle = TextStyle(color: Color(0xFFD32F2F));
}
