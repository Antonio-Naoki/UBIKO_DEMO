import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the text styles for the application, following Material 3 guidelines.
class AppFonts {
  /// Style for large, prominent headlines.
  /// Equivalent to Material 3's `headlineLarge`.
  static final TextStyle headlineLarge = GoogleFonts.lato(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  /// Style for standard titles, like in an AppBar.
  /// Equivalent to Material 3's `titleLarge`.
  static final TextStyle titleLarge = GoogleFonts.lato(
    fontSize: 22,
    fontWeight: FontWeight.w600, // Semi-bold for a strong but not overpowering title
  );

  /// Style for the main body text.
  /// Equivalent to Material 3's `bodyLarge`.
  static final TextStyle bodyLarge = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  /// Style for smaller body text or captions.
  /// Equivalent to Material 3's `bodyMedium`.
  static final TextStyle bodyMedium = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  /// Style for buttons.
  static final TextStyle labelLarge = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );
}
