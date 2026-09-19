import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = _build(AppColorsExtension.light, Brightness.light);
  static ThemeData dark = _build(AppColorsExtension.dark, Brightness.dark);

  static ThemeData _build(AppColorsExtension c, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: c.bg,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: c.primary,
        onPrimary: c.onPrimary,
        secondary: c.accent,
        onSecondary: c.onAccent,
        error: c.error,
        onError: c.onPrimary,
        surface: c.surface,
        onSurface: c.textPrimary,
      ),
      extensions: [c],
      appBarTheme: AppBarTheme(
        backgroundColor: c.bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: c.textPrimary),
        titleTextStyle: AppTextStyles.titleL20(c.textPrimary),
      ),
      textTheme: TextTheme(
        displayMedium: AppTextStyles.displayXl34(c.textPrimary),
        headlineMedium: AppTextStyles.headlineXl28(c.textPrimary),
        titleLarge: AppTextStyles.titleL24(c.textPrimary),
        titleMedium: AppTextStyles.titleL20(c.textPrimary),
        bodyLarge: AppTextStyles.bodyM16(c.textPrimary),
        bodyMedium: AppTextStyles.bodyM15(c.textSecondary),
        bodySmall: AppTextStyles.bodyS13(c.textSecondary),
        labelLarge: AppTextStyles.labelM16(c.onPrimary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: c.primary,
          foregroundColor: c.onPrimary,
          minimumSize: const Size.fromHeight(AppSizes.buttonH56),
          textStyle: AppTextStyles.labelM16(c.onPrimary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM16),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: c.primary.withValues(alpha: 0.06),
          foregroundColor: c.primary,
          side: BorderSide(color: c.primary.withValues(alpha: 0.4)),
          minimumSize: const Size.fromHeight(AppSizes.buttonH56),
          textStyle: AppTextStyles.labelM16(c.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusM16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceRaised,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.m16,
          vertical: AppSizes.m12,
        ),
        hintStyle: AppTextStyles.bodyM15(c.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM12),
          borderSide: BorderSide(color: c.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM12),
          borderSide: BorderSide(color: c.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM12),
          borderSide: BorderSide(color: c.primary, width: 1.5),
        ),
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM16),
          side: BorderSide(color: c.border),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.chipBg,
        labelStyle: AppTextStyles.labelS13(c.textPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusFull999),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.m12,
          vertical: AppSizes.xs4,
        ),
      ),
      dividerTheme: DividerThemeData(color: c.border, thickness: 1, space: 1),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: c.surface,
        selectedItemColor: c.primary,
        unselectedItemColor: c.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }
}
