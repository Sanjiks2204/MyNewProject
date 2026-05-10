import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mechzo_design/mechzo_design.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  final _slides = const [
    _Slide(
      icon: Icons.support_agent_rounded,
      title: 'Help arrives in minutes',
      body:
          'Verified garages, certified mechanics, and trained VIRA assistants — ready when you need them.',
      accent: MColors.coral500,
    ),
    _Slide(
      icon: Icons.shield_outlined,
      title: 'Trust built into every job',
      body:
          'Every VIRA assistant is KYC-verified, skill-tested, and rated by the people they help.',
      accent: MColors.mint500,
    ),
    _Slide(
      icon: Icons.bolt_rounded,
      title: 'Transparent prices, clear ETAs',
      body:
          'See parts prices upfront. Watch your provider en route. Pay only what was quoted.',
      accent: MColors.amber500,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        gradient: MColors.coralGradient,
                        borderRadius: MRadius.all(MRadius.s),
                      ),
                      child: const Icon(Icons.bolt_rounded,
                          size: 18, color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    Text('Mechzo',
                        style: Theme.of(context).textTheme.titleLarge),
                  ]),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text('Skip'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => _SlideView(slide: _slides[i]),
              ),
            ),
            _Dots(count: _slides.length, active: _page),
            const SizedBox(height: MSpace.x24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MSpace.x20),
              child: MButton(
                label: _page == _slides.length - 1 ? 'Get started' : 'Next',
                trailing: Icons.arrow_forward_rounded,
                onPressed: () {
                  if (_page == _slides.length - 1) {
                    context.go('/login');
                  } else {
                    _controller.nextPage(
                      duration: MMotion.expressive,
                      curve: MMotion.spring,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: MSpace.x24),
          ],
        ),
      ),
    );
  }
}

class _Slide {
  const _Slide({
    required this.icon,
    required this.title,
    required this.body,
    required this.accent,
  });
  final IconData icon;
  final String title;
  final String body;
  final Color accent;
}

class _SlideView extends StatelessWidget {
  const _SlideView({required this.slide});
  final _Slide slide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MSpace.x24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: slide.accent.withOpacity(0.12),
              borderRadius: MRadius.all(MRadius.xxl),
            ),
            child: Icon(slide.icon, size: 56, color: slide.accent),
          ),
          const SizedBox(height: MSpace.x32),
          Text(slide.title,
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: MSpace.x12),
          Text(slide.body,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: MColors.ink500,
                    height: 1.55,
                  )),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.active});
  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == active;
        return AnimatedContainer(
          duration: MMotion.standard,
          curve: MMotion.spring,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? MColors.coral500 : MColors.ink200,
            borderRadius: MRadius.all(MRadius.pill),
          ),
        );
      }),
    );
  }
}
