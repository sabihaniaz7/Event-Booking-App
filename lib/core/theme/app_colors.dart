import 'package:flutter/material.dart';

/// Core brand palette
class AppPalette {
  AppPalette._();

  // Brand blues
  static const Color skyTeal = Color(0xFF4F92B3); // primary
  static const Color midBlue = Color(0xFF44779F); // primary variant
  static const Color deepNavy = Color(
    0xFF325871,
  ); // primary dark / dark-mode surface tint
  static const Color mistBlue = Color(0xFF929EB8); // secondary / muted
  static const Color cream = Color(0xFFFFFDF6); // light bg

  // Warm accent (booking CTA — confirmations, ticket highlights)
  static const Color emberOrange = Color(0xFFE8834A);
  static const Color emberOrangeDeep = Color(0xFFC96A36);

  // Status
  static const Color success = Color(0xFF3F9E6C);
  static const Color warning = Color(0xFFD9A441);
  static const Color error = Color(0xFFD1554A);

  // Neutrals — light mode
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF7F7F5);
  static const Color neutral100 = Color(0xFFEFEFEC);
  static const Color neutral300 = Color(0xFFD3D3CE);
  static const Color neutral500 = Color(0xFF8E8E86);
  static const Color neutral700 = Color(0xFF4A4A46);
  static const Color neutral900 = Color(0xFF1E1E1C);

  // Neutrals — dark mode (slightly blue-tinted, not pure black — matches deepNavy)
  static const Color darkBg = Color(0xFF12181D);
  static const Color darkSurface = Color(0xFF1A2229);
  static const Color darkSurfaceRaised = Color(0xFF212B33);
  static const Color darkBorder = Color(0xFF2E3941);
  static const Color darkTextPrimary = Color(0xFFF2F3F1);
  static const Color darkTextSecondary = Color(0xFFAEB6BB);
}

/// ThemeExtension carrying every semantic color the app uses.
/// Access anywhere via: `Theme.of(context).extension<AppColorsExtension>()!`
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.bg,
    required this.surface,
    required this.surfaceRaised,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.primary,
    required this.primaryVariant,
    required this.onPrimary,
    required this.accent,
    required this.onAccent,
    required this.success,
    required this.warning,
    required this.error,
    required this.chipBg,
    required this.shadow,
  });

  final Color bg;
  final Color surface;
  final Color surfaceRaised;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color primary;
  final Color primaryVariant;
  final Color onPrimary;
  final Color accent;
  final Color onAccent;
  final Color success;
  final Color warning;
  final Color error;
  final Color chipBg;
  final Color shadow;

  static const light = AppColorsExtension(
    bg: AppPalette.cream,
    surface: AppPalette.neutral0,
    surfaceRaised: AppPalette.neutral0,
    border: AppPalette.neutral100,
    textPrimary: AppPalette.neutral900,
    textSecondary: AppPalette.neutral500,
    textDisabled: AppPalette.neutral300,
    primary: AppPalette.midBlue,
    primaryVariant: AppPalette.deepNavy,
    onPrimary: AppPalette.neutral0,
    accent: AppPalette.emberOrange,
    onAccent: AppPalette.neutral0,
    success: AppPalette.success,
    warning: AppPalette.warning,
    error: AppPalette.error,
    chipBg: AppPalette.neutral50,
    shadow: Color(0x14325871),
  );

  static const dark = AppColorsExtension(
    bg: AppPalette.darkBg,
    surface: AppPalette.darkSurface,
    surfaceRaised: AppPalette.darkSurfaceRaised,
    border: AppPalette.darkBorder,
    textPrimary: AppPalette.darkTextPrimary,
    textSecondary: AppPalette.darkTextSecondary,
    textDisabled: Color(0xFF4A555C),
    primary: AppPalette.skyTeal,
    primaryVariant: AppPalette.mistBlue,
    onPrimary: AppPalette.darkBg,
    accent: AppPalette.emberOrange,
    onAccent: AppPalette.darkBg,
    success: AppPalette.success,
    warning: AppPalette.warning,
    error: Color(0xFFE07A70),
    chipBg: AppPalette.darkSurfaceRaised,
    shadow: Color(0x40000000),
  );

  @override
  AppColorsExtension copyWith({
    Color? bg,
    Color? surface,
    Color? surfaceRaised,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
    Color? primary,
    Color? primaryVariant,
    Color? onPrimary,
    Color? accent,
    Color? onAccent,
    Color? success,
    Color? warning,
    Color? error,
    Color? chipBg,
    Color? shadow,
  }) {
    return AppColorsExtension(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      surfaceRaised: surfaceRaised ?? this.surfaceRaised,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textDisabled: textDisabled ?? this.textDisabled,
      primary: primary ?? this.primary,
      primaryVariant: primaryVariant ?? this.primaryVariant,
      onPrimary: onPrimary ?? this.onPrimary,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      chipBg: chipBg ?? this.chipBg,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceRaised: Color.lerp(surfaceRaised, other.surfaceRaised, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryVariant: Color.lerp(primaryVariant, other.primaryVariant, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      chipBg: Color.lerp(chipBg, other.chipBg, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}

/// Convenience getter: `context.colors.primary`
extension AppColorsContext on BuildContext {
  AppColorsExtension get colors =>
      Theme.of(this).extension<AppColorsExtension>()!;
}
