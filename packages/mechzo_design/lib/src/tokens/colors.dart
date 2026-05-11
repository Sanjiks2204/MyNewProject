import 'package:flutter/material.dart';

/// Mechzo color tokens.
///
/// Why these specific values: midnight ink communicates trust and
/// professionalism (banking/fintech feel). Signal coral is warm and
/// assertive without the panic of pure red. Mint gives a fresh,
/// modern success state — distinct from the red/yellow sea of
/// utility service apps.
class MColors {
  const MColors._();

  // Ink scale — primary neutrals
  static const ink900 = Color(0xFF0A1628);
  static const ink800 = Color(0xFF142239);
  static const ink700 = Color(0xFF1F2D45);
  static const ink600 = Color(0xFF38445C);
  static const ink500 = Color(0xFF5A6478);
  static const ink400 = Color(0xFF7E8798);
  static const ink300 = Color(0xFFA8B0BD);
  static const ink200 = Color(0xFFC9CFD9);
  static const ink100 = Color(0xFFE4E8EE);
  static const ink050 = Color(0xFFF4F6FA);

  static const white = Color(0xFFFFFFFF);

  // Brand accent — coral
  static const coral700 = Color(0xFFCC3D32);
  static const coral500 = Color(0xFFFF5A4E);
  static const coral400 = Color(0xFFFF7B71);
  static const coral200 = Color(0xFFFFC2BC);
  static const coral100 = Color(0xFFFFE5E2);

  // Status — success
  static const mint700 = Color(0xFF008F6B);
  static const mint500 = Color(0xFF00C896);
  static const mint300 = Color(0xFF6CE0BA);
  static const mint100 = Color(0xFFD6F7EC);

  // Status — warning
  static const amber700 = Color(0xFFCC8A1F);
  static const amber500 = Color(0xFFFFB02E);
  static const amber100 = Color(0xFFFFEFCD);

  // Status — error
  static const crimson700 = Color(0xFFB12C29);
  static const crimson500 = Color(0xFFE53935);
  static const crimson100 = Color(0xFFFCE0DF);

  // Decorative gradients
  static const heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A1628), Color(0xFF1F2D45)],
  );

  static const coralGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF7B71), Color(0xFFFF5A4E)],
  );

  static const mintGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6CE0BA), Color(0xFF00C896)],
  );
}
