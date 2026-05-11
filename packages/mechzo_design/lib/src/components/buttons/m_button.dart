import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tokens/colors.dart';
import '../../tokens/elevation.dart';
import '../../tokens/motion.dart';
import '../../tokens/radii.dart';
import '../../tokens/typography.dart';

enum MButtonVariant { primary, secondary, ghost, destructive }
enum MButtonSize { small, medium, large }

/// Mechzo button. Springy press, elevation lift, haptic on tap.
class MButton extends StatefulWidget {
  const MButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = MButtonVariant.primary,
    this.size = MButtonSize.large,
    this.icon,
    this.trailing,
    this.expand = true,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final MButtonVariant variant;
  final MButtonSize size;
  final IconData? icon;
  final IconData? trailing;
  final bool expand;
  final bool loading;

  @override
  State<MButton> createState() => _MButtonState();
}

class _MButtonState extends State<MButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: MMotion.micro,
      reverseDuration: MMotion.quick,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _ctrl, curve: MMotion.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  bool get _enabled => widget.onPressed != null && !widget.loading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final colors = _resolveColors(widget.variant, scheme, isDark);
    final height = switch (widget.size) {
      MButtonSize.small => 40.0,
      MButtonSize.medium => 48.0,
      MButtonSize.large => 56.0,
    };
    final hPad = switch (widget.size) {
      MButtonSize.small => 14.0,
      MButtonSize.medium => 18.0,
      MButtonSize.large => 22.0,
    };
    final fontSize = switch (widget.size) {
      MButtonSize.small => 13.0,
      MButtonSize.medium => 14.0,
      MButtonSize.large => 15.0,
    };

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _enabled ? (_) => _ctrl.forward() : null,
      onTapCancel: _enabled ? () => _ctrl.reverse() : null,
      onTapUp: _enabled
          ? (_) {
              _ctrl.reverse();
              HapticFeedback.lightImpact();
              widget.onPressed?.call();
            }
          : null,
      child: ScaleTransition(
        scale: _scale,
        child: AnimatedContainer(
          duration: MMotion.quick,
          curve: MMotion.easeOut,
          height: height,
          width: widget.expand ? double.infinity : null,
          padding: EdgeInsets.symmetric(horizontal: hPad),
          decoration: BoxDecoration(
            color: _enabled ? colors.bg : colors.bg.withOpacity(0.5),
            borderRadius: MRadius.all(MRadius.m),
            border: colors.border != null
                ? Border.all(color: colors.border!, width: 1.2)
                : null,
            boxShadow: widget.variant == MButtonVariant.primary && _enabled
                ? MElevation.e2()
                : MElevation.e0(),
          ),
          child: _Content(
            label: widget.label,
            icon: widget.icon,
            trailing: widget.trailing,
            loading: widget.loading,
            color: _enabled ? colors.fg : colors.fg.withOpacity(0.5),
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }

  _MButtonColors _resolveColors(
    MButtonVariant v,
    ColorScheme scheme,
    bool isDark,
  ) {
    switch (v) {
      case MButtonVariant.primary:
        return _MButtonColors(
          bg: scheme.primary,
          fg: scheme.onPrimary,
        );
      case MButtonVariant.secondary:
        return _MButtonColors(
          bg: scheme.secondary,
          fg: scheme.onSecondary,
        );
      case MButtonVariant.ghost:
        return _MButtonColors(
          bg: Colors.transparent,
          fg: scheme.onSurface,
          border: scheme.outline,
        );
      case MButtonVariant.destructive:
        return _MButtonColors(
          bg: MColors.crimson500,
          fg: MColors.white,
        );
    }
  }
}

class _MButtonColors {
  _MButtonColors({required this.bg, required this.fg, this.border});
  final Color bg;
  final Color fg;
  final Color? border;
}

class _Content extends StatelessWidget {
  const _Content({
    required this.label,
    required this.icon,
    required this.trailing,
    required this.loading,
    required this.color,
    required this.fontSize,
  });

  final String label;
  final IconData? icon;
  final IconData? trailing;
  final bool loading;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            label,
            style: MType.numeric(
              size: fontSize,
              weight: FontWeight.w600,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 8),
          Icon(trailing, size: 18, color: color),
        ],
      ],
    );
  }
}
