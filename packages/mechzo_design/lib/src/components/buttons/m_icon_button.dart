import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tokens/motion.dart';
import '../../tokens/radii.dart';

class MIconButton extends StatefulWidget {
  const MIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 44,
    this.iconSize = 20,
    this.background,
    this.foreground,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final Color? background;
  final Color? foreground;

  @override
  State<MIconButton> createState() => _MIconButtonState();
}

class _MIconButtonState extends State<MIconButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: MMotion.micro,
    reverseDuration: MMotion.quick,
  );

  late final Animation<double> _scale =
      Tween(begin: 1.0, end: 0.92).animate(_ctrl);

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bg = widget.background ?? scheme.surfaceContainerHighest;
    final fg = widget.foreground ?? scheme.onSurface;

    return GestureDetector(
      onTapDown: widget.onPressed == null ? null : (_) => _ctrl.forward(),
      onTapCancel: widget.onPressed == null ? null : () => _ctrl.reverse(),
      onTapUp: widget.onPressed == null
          ? null
          : (_) {
              _ctrl.reverse();
              HapticFeedback.lightImpact();
              widget.onPressed?.call();
            },
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: MRadius.all(MRadius.pill),
          ),
          child: Icon(widget.icon, size: widget.iconSize, color: fg),
        ),
      ),
    );
  }
}
