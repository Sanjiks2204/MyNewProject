import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radii.dart';
import '../../tokens/spacing.dart';
import '../../tokens/typography.dart';
import 'm_pulse_dot.dart';

enum MStatusTone { neutral, info, success, warning, danger }

/// Compact pill — used for job status, account state, etc.
class MStatusPill extends StatelessWidget {
  const MStatusPill({
    super.key,
    required this.label,
    this.tone = MStatusTone.neutral,
    this.pulse = false,
    this.icon,
  });

  final String label;
  final MStatusTone tone;
  final bool pulse;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = _toneColors(tone, Theme.of(context));
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MSpace.x12,
        vertical: MSpace.x8,
      ),
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: MRadius.all(MRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (pulse) ...[
            MPulseDot(color: colors.fg, size: 8),
            const SizedBox(width: MSpace.x8),
          ] else if (icon != null) ...[
            Icon(icon, size: 14, color: colors.fg),
            const SizedBox(width: MSpace.x4),
          ],
          Text(
            label,
            style: MType.numeric(
              size: 12,
              weight: FontWeight.w600,
              color: colors.fg,
            ),
          ),
        ],
      ),
    );
  }

  _ToneColors _toneColors(MStatusTone tone, ThemeData theme) {
    switch (tone) {
      case MStatusTone.success:
        return _ToneColors(MColors.mint100, MColors.mint700);
      case MStatusTone.warning:
        return _ToneColors(MColors.amber100, MColors.amber700);
      case MStatusTone.danger:
        return _ToneColors(MColors.crimson100, MColors.crimson700);
      case MStatusTone.info:
        return _ToneColors(MColors.coral100, MColors.coral700);
      case MStatusTone.neutral:
        return _ToneColors(
          theme.colorScheme.surfaceContainerHighest,
          theme.colorScheme.onSurface,
        );
    }
  }
}

class _ToneColors {
  _ToneColors(this.bg, this.fg);
  final Color bg;
  final Color fg;
}
