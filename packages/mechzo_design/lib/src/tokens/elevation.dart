import 'package:flutter/material.dart';

import 'colors.dart';

/// Soft, multi-layered elevation. Never harsh.
class MElevation {
  const MElevation._();

  static List<BoxShadow> e0() => const [];

  static List<BoxShadow> e1() => [
        BoxShadow(
          color: MColors.ink900.withOpacity(0.04),
          offset: const Offset(0, 1),
          blurRadius: 2,
        ),
        BoxShadow(
          color: MColors.ink900.withOpacity(0.02),
          offset: const Offset(0, 1),
          blurRadius: 1,
        ),
      ];

  static List<BoxShadow> e2() => [
        BoxShadow(
          color: MColors.ink900.withOpacity(0.06),
          offset: const Offset(0, 4),
          blurRadius: 12,
        ),
        BoxShadow(
          color: MColors.ink900.withOpacity(0.03),
          offset: const Offset(0, 2),
          blurRadius: 4,
        ),
      ];

  static List<BoxShadow> e3() => [
        BoxShadow(
          color: MColors.ink900.withOpacity(0.10),
          offset: const Offset(0, 12),
          blurRadius: 28,
        ),
        BoxShadow(
          color: MColors.ink900.withOpacity(0.04),
          offset: const Offset(0, 4),
          blurRadius: 8,
        ),
      ];

  static List<BoxShadow> e4() => [
        BoxShadow(
          color: MColors.ink900.withOpacity(0.14),
          offset: const Offset(0, 24),
          blurRadius: 48,
        ),
        BoxShadow(
          color: MColors.ink900.withOpacity(0.06),
          offset: const Offset(0, 8),
          blurRadius: 16,
        ),
      ];
}
