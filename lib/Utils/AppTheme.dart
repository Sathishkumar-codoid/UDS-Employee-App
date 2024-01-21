

import 'package:uds_employee/Utils/AppThemeManager.dart';

import '../Allnavigations/AllimportedDirectory.dart';
import 'package:flutter/material.dart';

abstract class AppTheme{
  static const Color primaryColor1=Color(0xFFF79C37);
  static const Color whiteColor=Color(0xFFFFFFFF);
    static const Color primaryColor2=Color(0xFFF26639);
  static const Color blackColor = Color(0xFF000000);
  static const Color LightGrey = Color(0xFFE5E4E2);
  static const Color BottomNavColor = Color(0xFFFBFBFB);
  static const Color backgroundColor = Color(0x00ffffff);
  static const Color themeLightGrey = Color(0xFF959393);
  static const Color themeDarkGrey = Color(0xFF555454);
  static const Color FontGrey = Color(0xFF626262);
  static const Color calendarColor = Color(0xFFF5F5F5);
  static const Color presentColor = Color(0xFF1FDC0F);
  static const Color absentColor = Color(0xFFFF0000);
  static const Color weekOffColor = Color(0xFFFBD9CD);
  static const Color todayColor = Color(0xFF9C9C9C);
  static const Color  attendanceColor = Color(0xFFF79C371A);
  static const Color  attendanceTextColor = Color(0xFF9C9C9C);
  static const Color  buttonColor = Color(0xFFEF4D39);
  static const Color  bgColor = Color(0xFFFFF);
  static const Color  fillColor = Color(0xFD9D9D9);
  static const Color grey = Color(0xFF707070);

  static TextStyle customTextStyleWithSize(
      {required double size,
        FontWeight weight = FontWeight.bold,
        Color? color,
        double lineSpace = 1.0,
        bool isUnderlined = false,
        Color? underlineColor,
        double underlineThickness = 1.0}) {
    return TextStyle(
      fontFamily: AppThemeManager.defaultFontMetro,
      fontSize: 12.0.sp,
      letterSpacing: 0.3.sp,
      fontWeight: FontWeight.w500,
      color: AppTheme.primaryColor1,
      decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
      decorationColor: underlineColor,
      decorationThickness: underlineThickness,
      backgroundColor: AppTheme.backgroundColor,
    );
  }



}