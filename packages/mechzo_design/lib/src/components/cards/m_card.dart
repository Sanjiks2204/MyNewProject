import 'package:flutter/material.dart';

import '../../tokens/elevation.dart';
import '../../tokens/radii.dart';
import '../../tokens/spacing.dart';

/// Surface card with subtle border + soft shadow.
class MCard extends StatelessWidget {
  const MCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(MSpace.x16),
    this.onTap,
    this.elevation = 1,
    this.background,
    this.radius = MRadius.l,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final int elevation;
  final Color? background;
  final double radius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final shadow = switch (elevation) {
      0 => MElevation.e0(),
      1 => MElevation.e1(),
      2 => MElevation.e2(),
      3 => MElevation.e3(),
      _ => MElevation.e4(),
    };

    final card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background ?? scheme.surface,
        borderRadius: MRadius.all(radius),
        border: Border.all(color: borderColor ?? scheme.outline),
        boxShadow: shadow,
      ),
      child: child,
    );

    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      borderRadius: MRadius.all(radius),
      child: InkWell(
        borderRadius: MRadius.all(radius),
        onTap: onTap,
        child: card,
      ),
    );
  }
}
