import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../tokens/colors.dart';
import '../tokens/radii.dart';
import '../tokens/typography.dart';

/// Single source of truth for ThemeData in every Mechzo app.
class MTheme {
  const MTheme._();

  static ThemeData light() {
    final scheme = const ColorScheme.light(
      primary: MColors.ink900,
      onPrimary: MColors.white,
      secondary: MColors.coral500,
      onSecondary: MColors.white,
      tertiary: MColors.mint500,
      onTertiary: MColors.white,
      surface: MColors.white,
      onSurface: MColors.ink900,
      surfaceContainerHighest: MColors.ink050,
      surfaceContainer: MColors.ink050,
      outline: MColors.ink100,
      outlineVariant: MColors.ink100,
      error: MColors.crimson500,
      onError: MColors.white,
    );

    return _build(scheme: scheme, brightness: Brightness.light);
  }

  static ThemeData dark() {
    final scheme = const ColorScheme.dark(
      primary: MColors.coral500,
      onPrimary: MColors.white,
      secondary: MColors.mint500,
      onSecondary: MColors.ink900,
      tertiary: MColors.amber500,
      onTertiary: MColors.ink900,
      surface: MColors.ink900,
      onSurface: MColors.ink050,
      surfaceContainerHighest: MColors.ink800,
      surfaceContainer: MColors.ink700,
      outline: MColors.ink600,
      outlineVariant: MColors.ink700,
      error: MColors.crimson500,
      onError: MColors.white,
    );

    return _build(scheme: scheme, brightness: Brightness.dark);
  }

  static ThemeData _build({
    required ColorScheme scheme,
    required Brightness brightness,
  }) {
    final isDark = brightness == Brightness.dark;
    final onSurface = scheme.onSurface;
    final onSurfaceMuted = isDark ? MColors.ink300 : MColors.ink500;

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
      scaffoldBackgroundColor: scheme.surface,
      splashFactory: InkRipple.splashFactory,
    );

    return base.copyWith(
      textTheme: MType.textTheme(onSurface, onSurfaceMuted),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          minimumSize: const Size.fromHeight(56),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: MRadius.all(MRadius.m),
          ),
          textStyle: MType.textTheme(onSurface, onSurfaceMuted).labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: onSurface,
          minimumSize: const Size.fromHeight(56),
          side: BorderSide(color: scheme.outline, width: 1.2),
          shape: RoundedRectangleBorder(
            borderRadius: MRadius.all(MRadius.m),
          ),
          textStyle: MType.textTheme(onSurface, onSurfaceMuted).labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.secondary,
          textStyle: MType.textTheme(onSurface, onSurfaceMuted).labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? MColors.ink800 : MColors.ink050,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        hintStyle: TextStyle(color: onSurfaceMuted),
        border: OutlineInputBorder(
          borderRadius: MRadius.all(MRadius.m),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: MRadius.all(MRadius.m),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: MRadius.all(MRadius.m),
          borderSide: BorderSide(color: scheme.secondary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: MRadius.all(MRadius.m),
          borderSide: const BorderSide(color: MColors.crimson500, width: 1.4),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outline,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: MRadius.all(MRadius.l),
          side: BorderSide(color: scheme.outline),
        ),
      ),
    );
  }
}
