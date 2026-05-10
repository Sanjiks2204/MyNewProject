import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mechzo_design/mechzo_design.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoCtrl;
  late final AnimationController _textCtrl;

  @override
  void initState() {
    super.initState();
    _logoCtrl = AnimationController(
      vsync: this,
      duration: MMotion.dramatic,
    )..forward();
    _textCtrl = AnimationController(
      vsync: this,
      duration: MMotion.expressive,
    );
    Future.delayed(const Duration(milliseconds: 280), () => _textCtrl.forward());
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) context.go('/onboarding');
    });
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _textCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.ink900,
      body: Stack(
        children: [
          _GradientBackdrop(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: Tween<double>(begin: 0.6, end: 1.0).animate(
                    CurvedAnimation(parent: _logoCtrl, curve: MMotion.spring),
                  ),
                  child: FadeTransition(
                    opacity: _logoCtrl,
                    child: const _MechzoMark(),
                  ),
                ),
                const SizedBox(height: MSpace.x24),
                FadeTransition(
                  opacity: _textCtrl,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.4),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(parent: _textCtrl, curve: MMotion.easeOut),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Mechzo',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(color: MColors.white),
                        ),
                        const SizedBox(height: MSpace.x8),
                        Text(
                          'Trusted help, on the way.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: MColors.ink300),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientBackdrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.4),
          radius: 1.3,
          colors: [Color(0xFF1F2D45), Color(0xFF0A1628)],
        ),
      ),
    );
  }
}

class _MechzoMark extends StatelessWidget {
  const _MechzoMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        gradient: MColors.coralGradient,
        borderRadius: MRadius.all(MRadius.xxl),
        boxShadow: [
          BoxShadow(
            color: MColors.coral500.withOpacity(0.6),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.bolt_rounded, size: 52, color: MColors.white),
      ),
    );
  }
}
