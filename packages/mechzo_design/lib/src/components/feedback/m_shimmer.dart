import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radii.dart';

/// Lightweight shimmer skeleton — used for placeholder loading states.
class MShimmer extends StatefulWidget {
  const MShimmer({
    super.key,
    this.width,
    this.height = 16,
    this.radius = MRadius.s,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  State<MShimmer> createState() => _MShimmerState();
}

class _MShimmerState extends State<MShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? MColors.ink800 : MColors.ink100;
    final highlight = isDark ? MColors.ink700 : MColors.ink050;

    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => ShaderMask(
        shaderCallback: (rect) => LinearGradient(
          begin: const Alignment(-1.5, 0),
          end: const Alignment(1.5, 0),
          stops: [0.0, _ctrl.value, 1.0],
          colors: [base, highlight, base],
        ).createShader(rect),
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: MRadius.all(widget.radius),
          ),
        ),
      ),
    );
  }
}
