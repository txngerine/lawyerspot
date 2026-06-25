import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Color palette derived from the LawyerSpot design tokens
/// (navy / gold premium legal-marketplace aesthetic).
class AppColors {
  AppColors._();

  static const navy = Color(0xFF040D2A); // primary
  static const navyContainer = Color(0xFF1A2340); // primary-container
  static const navyFixedDim = Color(0xFFBDC5EA);

  static const gold = Color(0xFFC9A24B); // brand accent gold
  static const goldDark = Color(0xFF795902); // secondary
  static const goldLight = Color(0xFFFDD275); // secondary-container

  static const ivory = Color(0xFFFAF8F4); // app background
  static const surface = Color(0xFFFBF9F8);
  static const cardLowest = Color(0xFFFFFFFF);
  static const surfaceContainer = Color(0xFFEFEDED);
  static const surfaceContainerHigh = Color(0xFFEAE8E7);

  static const outline = Color(0xFF76767E);
  static const outlineVariant = Color(0xFFC6C6CE);

  static const onSurface = Color(0xFF1B1C1C);
  static const onSurfaceVariant = Color(0xFF45464D);

  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);

  static const success = Color(0xFF2E7D32);

  static const cardShadow = Color(0x0A040D2A); // ~4% navy
}

class AppText {
  AppText._();

  static TextStyle displayLg = GoogleFonts.playfairDisplay(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: AppColors.navy,
  );

  static TextStyle displayLgMobile = GoogleFonts.playfairDisplay(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.navy,
  );

  static TextStyle headlineMd = GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.navy,
  );

  static TextStyle titleLg = GoogleFonts.manrope(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.navy,
  );

  static TextStyle bodyMd = GoogleFonts.manrope(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurface,
  );

  static TextStyle bodySm = GoogleFonts.manrope(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.onSurfaceVariant,
  );

  static TextStyle labelCaps = GoogleFonts.manrope(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.0,
    color: AppColors.onSurfaceVariant,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.ivory,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.navy,
        brightness: Brightness.light,
        primary: AppColors.navy,
        secondary: AppColors.goldDark,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      fontFamily: GoogleFonts.manrope().fontFamily,
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.onSurface,
        displayColor: AppColors.navy,
        fontFamily: GoogleFonts.manrope().fontFamily,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.navy,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.navy),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardLowest,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.outlineVariant.withOpacity(0.25)),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.goldDark
              : Colors.transparent,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardLowest,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.goldDark, width: 1.4),
        ),
        labelStyle: AppText.labelCaps,
        hintStyle: AppText.bodyMd.copyWith(color: AppColors.outline),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.goldDark,
          foregroundColor: Colors.white,
          textStyle: AppText.titleLg.copyWith(color: Colors.white),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 0,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.goldDark,
        unselectedItemColor: Color(0x66040D2A),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
