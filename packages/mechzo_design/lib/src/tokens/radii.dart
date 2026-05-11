import 'package:flutter/widgets.dart';

class MRadius {
  const MRadius._();
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double pill = 999;

  static BorderRadius all(double r) => BorderRadius.all(Radius.circular(r));
}
