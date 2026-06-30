import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  // Primary – Deep Navy
  static const primary = Color(0xFF0B2340);
  static const primaryContainer = Color(0xFF1A344F);
  static const primaryFixedDim = Color(0xFFB0C4DE);

  // Secondary – Brand Blue
  static const secondary = Color(0xFF1565D8);
  static const secondaryContainer = Color(0xFFD6E4FF);

  // Accent – Gold Amber
  static const accent = Color(0xFFF6C24F);
  static const accentContainer = Color(0xFFFFF3D6);

  // Support – Teal Cyan
  static const support = Color(0xFF17A2B8);
  static const supportContainer = Color(0xFFD6F5FA);

  // Surfaces
  static const surface = Color(0xFFFFFFFF);
  static const surfaceAlt = Color(0xFFF6F8FA);
  static const surfaceContainer = Color(0xFFEEF0F2);
  static const surfaceContainerHigh = Color(0xFFE6E8EA);

  // Text
  static const onSurface = Color(0xFF1F2933);
  static const onSurfaceVariant = Color(0xFF4A5568);

  // Outline / Border
  static const outline = Color(0xFF6B7280);
  static const outlineVariant = Color(0xFFD1D5DB);

  // Semantic
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);
  static const success = Color(0xFF2E7D32);

  // Shadows
  static const cardShadow = Color(0x0A0B2340);
}

class AppText {
  AppText._();

  static TextStyle displayLg = GoogleFonts.playfairDisplay(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    color: AppColors.primary,
  );

  static TextStyle displayLgMobile = GoogleFonts.playfairDisplay(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle headlineMd = GoogleFonts.playfairDisplay(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle titleLg = GoogleFonts.manrope(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
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
      scaffoldBackgroundColor: AppColors.surfaceAlt,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      fontFamily: GoogleFonts.manrope().fontFamily,
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.onSurface,
        displayColor: AppColors.primary,
        fontFamily: GoogleFonts.manrope().fontFamily,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.primary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
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
              ? AppColors.secondary
              : Colors.transparent,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
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
          borderSide: const BorderSide(color: AppColors.secondary, width: 1.4),
        ),
        labelStyle: AppText.labelCaps,
        hintStyle: AppText.bodyMd.copyWith(color: AppColors.outline),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
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
        selectedItemColor: AppColors.secondary,
        unselectedItemColor: Color(0x660B2340),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
