import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_sizes.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle _base({
    required double size,
    required FontWeight weight,
    double? height,
    double? letterSpacing,
    required Color color,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    );
  }

  // Display / headline
  static TextStyle displayXl34(Color color) => _base(
    size: AppSizes.fontXl34,
    weight: FontWeight.w700,
    height: 1.2,
    color: color,
  );
  static TextStyle headlineXl28(Color color) => _base(
    size: AppSizes.fontXl28,
    weight: FontWeight.w700,
    height: 1.25,
    color: color,
  );
  static TextStyle titleL24(Color color) => _base(
    size: AppSizes.fontL24,
    weight: FontWeight.w600,
    height: 1.3,
    color: color,
  );
  static TextStyle titleL20(Color color) => _base(
    size: AppSizes.fontL20,
    weight: FontWeight.w600,
    height: 1.3,
    color: color,
  );

  // Body
  static TextStyle bodyM16(Color color) => _base(
    size: AppSizes.fontM16,
    weight: FontWeight.w400,
    height: 1.5,
    color: color,
  );
  static TextStyle bodyM15(Color color) => _base(
    size: AppSizes.fontM15,
    weight: FontWeight.w400,
    height: 1.45,
    color: color,
  );
  static TextStyle bodyS13(Color color) => _base(
    size: AppSizes.fontS13,
    weight: FontWeight.w400,
    height: 1.4,
    color: color,
  );

  // Emphasis / labels
  static TextStyle labelM16(Color color) => _base(
    size: AppSizes.fontM16,
    weight: FontWeight.w600,
    height: 1.3,
    color: color,
  );
  static TextStyle labelS13(Color color) => _base(
    size: AppSizes.fontS13,
    weight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0.2,
    color: color,
  );
  static TextStyle captionXs11(Color color) => _base(
    size: AppSizes.fontXs11,
    weight: FontWeight.w500,
    height: 1.3,
    letterSpacing: 0.3,
    color: color,
  );

  // Ticket / price numbers (tabular figures matter for prices & QR codes)
  static TextStyle priceL20(Color color) => _base(
    size: AppSizes.fontL20,
    weight: FontWeight.w700,
    height: 1.2,
    color: color,
  );
}
