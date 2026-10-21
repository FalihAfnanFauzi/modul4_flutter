import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryNavy = Color(0xFF1E3A8A);
  static const Color slateGrey = Color(0xFF475569);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: backgroundLight,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryNavy,
          brightness: Brightness.light,
          primary: primaryNavy,
          onPrimary: Colors.white,
          secondary: slateGrey,
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: const Color(0xFF0F172A),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryNavy,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryNavy,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundDark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryNavy,
          brightness: Brightness.dark,
          primary: const Color(0xFF60A5FA),
          onPrimary: const Color(0xFF0F172A),
          secondary: const Color(0xFF94A3B8),
          onSecondary: const Color(0xFF0F172A),
          surface: surfaceDark,
          onSurface: const Color(0xFFF8FAFC),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: surfaceDark,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: surfaceDark,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Color(0xFF334155)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      );
}
