import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// Type scale — Plus Jakarta Sans for display, Inter for UI.
class MType {
  const MType._();

  static TextTheme textTheme(Color onSurface, Color onSurfaceMuted) {
    final display = GoogleFonts.plusJakartaSansTextTheme();
    final body = GoogleFonts.interTextTheme();

    return TextTheme(
      displayLarge: display.displayLarge?.copyWith(
        fontSize: 40,
        fontWeight: FontWeight.w800,
        height: 1.1,
        letterSpacing: -1.2,
        color: onSurface,
      ),
      displayMedium: display.displayMedium?.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -0.6,
        color: onSurface,
      ),
      displaySmall: display.displaySmall?.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.4,
        color: onSurface,
      ),
      headlineLarge: display.headlineLarge?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.25,
        letterSpacing: -0.2,
        color: onSurface,
      ),
      headlineMedium: display.headlineMedium?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: -0.2,
        color: onSurface,
      ),
      titleLarge: body.titleLarge?.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        height: 1.35,
        color: onSurface,
      ),
      titleMedium: body.titleMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: onSurface,
      ),
      titleSmall: body.titleSmall?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: onSurface,
      ),
      bodyLarge: body.bodyLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: onSurface,
      ),
      bodyMedium: body.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: onSurfaceMuted,
      ),
      bodySmall: body.bodySmall?.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: onSurfaceMuted,
      ),
      labelLarge: body.labelLarge?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.1,
        color: onSurface,
      ),
      labelMedium: body.labelMedium?.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.4,
        letterSpacing: 0.1,
        color: onSurface,
      ),
      labelSmall: body.labelSmall?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.2,
        color: onSurfaceMuted,
      ),
    );
  }

  /// Tabular figures — for prices, ETAs, counts. Use as `style: MType.numeric()`.
  static TextStyle numeric({
    double size = 16,
    FontWeight weight = FontWeight.w600,
    Color color = MColors.ink900,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color,
      fontFeatures: const [FontFeature.tabularFigures()],
      letterSpacing: -0.1,
    );
  }
}
