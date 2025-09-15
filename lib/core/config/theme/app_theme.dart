import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './app_colors.dart';

class AppTheme {
  // The main seed color for the theme.
  static const Color _seedColor = AppColors.primaryColor;

  // The base TextTheme, created using GoogleFonts for a custom typography.
  static final TextTheme _appTextTheme = TextTheme(
    displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.openSans(fontSize: 14),
    labelLarge: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
  );

  // Getter for the light theme.
  static ThemeData get lightTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _appTextTheme.apply(bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        titleTextStyle: _appTextTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: _appTextTheme.labelLarge,
        ),
      ),
    );
  }

  // Getter for the dark theme.
  static ThemeData get darkTheme {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _appTextTheme.apply(bodyColor: colorScheme.onSurface, displayColor: colorScheme.onSurface),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: _appTextTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.inversePrimary,
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: _appTextTheme.labelLarge,
        ),
      ),
    );
  }
}
