import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFF3B302B);
  static const Color backgroundColor = Color(0xFFF7F3ED);
  static const Color surfaceColor = Color(0xFFFFFFFF);

  static const Color textPrimaryColor = Color(0xFF2C2622);
  static const Color textSecondaryColor = Color(0xFF8D8177);
  static const Color textMutedColor = Color(0xFFB5AAA0);

  static const Color accentColor = Color(0xFFB8955A);
  static const Color borderColor = Color(0xFFE8DED2);

  static final TextTheme textTheme = GoogleFonts.interTextTheme(
    const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -1.2,
        color: textPrimaryColor,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -0.8,
        color: textPrimaryColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: -0.6,
        color: textPrimaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: -0.4,
        color: textPrimaryColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: textPrimaryColor,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: textPrimaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: textPrimaryColor,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: textPrimaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textPrimaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: textPrimaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: textSecondaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: textPrimaryColor,
      ),
      labelMedium: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: textSecondaryColor,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.3,
        letterSpacing: 0.5,
        color: textSecondaryColor,
      ),
    ),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        brightness: Brightness.light,
      ),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        foregroundColor: textPrimaryColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        hintStyle: textTheme.bodyMedium?.copyWith(color: textMutedColor),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: accentColor, width: 1.2),
        ),
      ),
    );
  }
}
