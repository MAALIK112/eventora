import 'package:flutter/material.dart';

class AppShadows {
  static const List<BoxShadow> level0 = [];

  static const List<BoxShadow> level1 = [
    BoxShadow(color: Color(0x0A111827), offset: Offset(0, 1), blurRadius: 2),
    BoxShadow(
      color: Color(0x0DB45309),
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> level2 = [
    BoxShadow(
      color: Color(0x14111827),
      offset: Offset(0, -4),
      blurRadius: 20,
      spreadRadius: -2,
    ),
  ];

  static const List<BoxShadow> level3 = [
    BoxShadow(
      color: Color(0x40F59E0B),
      offset: Offset(0, 0),
      blurRadius: 16,
    ),
  ];

  static BoxDecoration get cardBorder => BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(217, 119, 6, 0.1),
          width: 1.0,
        ),
      );
}
