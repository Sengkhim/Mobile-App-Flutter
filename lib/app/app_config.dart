import 'package:flutter/material.dart';

class AppConfiguration {
  // late VoidCallback _voidCallback;
  static Color get primaryColor => Colors.black12;

  static Color get bgColor => Colors.grey.withOpacity(0.2);

  static double get horizontal => 25;

  static double get vertical => 6;

  static double get horizontalFrame => 15;

  static double get borderRadius => 15;

  static Style get style => Style();
}

class Style {
  static TextStyle titleStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.w800);

  static TextStyle subTitleStyle =
      TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600);

  static TextStyle trailingStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.w500);

  static TextStyle trailingStyles({double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          color: Colors.black,
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: fontSize);

  static TextStyle titleStyles(
          {double? fontSize, FontWeight? fontWeight, Color? color}) =>
      TextStyle(
        color: color,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: fontSize,
      );
}
