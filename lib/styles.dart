import 'package:flutter/material.dart';

class EventoraStyles {
  static const navy = Color(0xFF12233F);
  static const blue = Color(0xFF4264F0);
  static const blueSoft = Color(0xFFEAF0FF);
  static const orange = Color(0xFFFF9B62);
  static const ink = Color(0xFF17233C);
  static const muted = Color(0xFF778198);
  static const surface = Color(0xFFFFFFFF);
  static const background = Color(0xFFF7F8FC);

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme:
            ColorScheme.fromSeed(seedColor: blue, brightness: Brightness.light),
        fontFamily: 'Arial',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: ink,
        ),
        textTheme: const TextTheme(
          headlineMedium:
              TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: ink),
          titleLarge:
              TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ink),
          titleMedium:
              TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: ink),
          bodyMedium: TextStyle(fontSize: 14, height: 1.45, color: muted),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      );

  static BoxDecoration card({Color color = surface, double radius = 20}) =>
      BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
              color: Color(0x0C12233F), blurRadius: 24, offset: Offset(0, 8)),
        ],
      );
}
