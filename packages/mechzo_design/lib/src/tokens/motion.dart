import 'package:flutter/animation.dart';

/// Motion tokens. Every motion has meaning.
class MMotion {
  const MMotion._();

  // Durations
  static const Duration micro = Duration(milliseconds: 120);
  static const Duration quick = Duration(milliseconds: 200);
  static const Duration standard = Duration(milliseconds: 280);
  static const Duration expressive = Duration(milliseconds: 420);
  static const Duration dramatic = Duration(milliseconds: 640);

  // Curves
  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve easeIn = Curves.easeInCubic;
  static const Curve easeInOut = Curves.easeInOutCubic;

  /// Bouncy spring — use for hero, sheet, expressive transitions.
  /// Hand-tuned to feel alive without overshoot.
  static const Curve spring = _SpringCurve(stiffness: 280, damping: 24);

  /// Slower, more deliberate spring — for first-load reveals.
  static const Curve gentleSpring = _SpringCurve(stiffness: 160, damping: 22);
}

/// Critically-damped-ish spring approximation as a Curve.
class _SpringCurve extends Curve {
  const _SpringCurve({required this.stiffness, required this.damping});
  final double stiffness;
  final double damping;

  @override
  double transformInternal(double t) {
    // Approximate spring with overshoot then settle.
    final w = stiffness / 100;
    final z = damping / (2 * 10);
    final exp = (-z * w * t * 4).clamp(-12.0, 0.0);
    final wd = w * (1 - z * z).abs();
    final eased = 1 -
        (1 / (1 - z * z).abs()) *
            _exp(exp) *
            _cos(wd * t * 2 - 0.6);
    return eased.clamp(0.0, 1.05);
  }

  static double _exp(double x) {
    // small Taylor approx — Curves run on [0,1] so x stays bounded.
    double r = 1, term = 1;
    for (int i = 1; i < 12; i++) {
      term *= x / i;
      r += term;
    }
    return r;
  }

  static double _cos(double x) {
    double r = 1, term = 1;
    for (int i = 1; i < 10; i++) {
      term *= -x * x / ((2 * i - 1) * (2 * i));
      r += term;
    }
    return r;
  }
}
