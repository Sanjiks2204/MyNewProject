import 'package:flutter/material.dart';

/// Animated pulsing dot — signals "live" state.
class MPulseDot extends StatefulWidget {
  const MPulseDot({super.key, this.color = const Color(0xFF00C896), this.size = 10});
  final Color color;
  final double size;

  @override
  State<MPulseDot> createState() => _MPulseDotState();
}

class _MPulseDotState extends State<MPulseDot>
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
    return SizedBox(
      width: widget.size * 2.4,
      height: widget.size * 2.4,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          final t = _ctrl.value;
          return Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: (1 - t) * 0.5,
                child: Container(
                  width: widget.size + (widget.size * 1.2 * t),
                  height: widget.size + (widget.size * 1.2 * t),
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
