import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mechzo_design/mechzo_design.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key, required this.jobId});
  final String jobId;

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  int _stage = 0; // 0 matching, 1 matched, 2 en route, 3 arrived

  @override
  void initState() {
    super.initState();
    _advance();
  }

  void _advance() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _stage = 1);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _stage = 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.ink050,
      body: Stack(
        children: [
          // Map placeholder — would be google_maps_flutter
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFE4E8EE), Color(0xFFF4F6FA)],
                ),
              ),
              child: Center(
                child: Icon(Icons.map_outlined,
                    size: 80, color: MColors.ink200.withOpacity(0.6)),
              ),
            ),
          ),
          // Top bar
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(MSpace.x16),
                child: Row(
                  children: [
                    MIconButton(
                      icon: Icons.arrow_back_rounded,
                      onPressed: () => context.go('/home'),
                      background: MColors.white,
                    ),
                    const Spacer(),
                    const MStatusPill(
                      label: 'Live',
                      tone: MStatusTone.success,
                      pulse: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom sheet
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.25,
            maxChildSize: 0.85,
            builder: (_, controller) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(MRadius.xxl),
                  ),
                  boxShadow: MElevation.e3(),
                ),
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.all(MSpace.x20),
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: MColors.ink200,
                          borderRadius: MRadius.all(MRadius.pill),
                        ),
                      ),
                    ),
                    const SizedBox(height: MSpace.x16),
                    _StageHeader(stage: _stage),
                    const SizedBox(height: MSpace.x16),
                    if (_stage >= 1) const _ProviderCard(),
                    const SizedBox(height: MSpace.x16),
                    const _Timeline(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StageHeader extends StatelessWidget {
  const _StageHeader({required this.stage});
  final int stage;
  @override
  Widget build(BuildContext context) {
    final (title, sub, eta) = switch (stage) {
      0 => ('Finding the nearest help', 'Usually under 30 seconds…', null),
      1 => ('Help is on the way', 'Rajesh accepted your request.', '8 min'),
      2 => ('Rajesh is heading to you', 'Stay safe. Track live below.', '6 min'),
      _ => ('Help has arrived', 'Rajesh is at your location.', '0 min'),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(title,
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            if (eta != null)
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: MColors.mint100,
                  borderRadius: MRadius.all(MRadius.m),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_rounded,
                        size: 16, color: MColors.mint700),
                    const SizedBox(width: 6),
                    Text(eta,
                        style: MType.numeric(
                          size: 14,
                          weight: FontWeight.w700,
                          color: MColors.mint700,
                        )),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(sub,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: MColors.ink500)),
      ],
    );
  }
}

class _ProviderCard extends StatelessWidget {
  const _ProviderCard();
  @override
  Widget build(BuildContext context) {
    return MCard(
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: MColors.mintGradient,
              borderRadius: MRadius.all(MRadius.pill),
            ),
            child: const Center(
              child: Text('R',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  )),
            ),
          ),
          const SizedBox(width: MSpace.x12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Rajesh K.',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: 6),
                    const Icon(Icons.verified_rounded,
                        size: 16, color: MColors.mint500),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 14, color: MColors.amber500),
                    const SizedBox(width: 4),
                    Text('4.9',
                        style: MType.numeric(
                          size: 13,
                          weight: FontWeight.w600,
                          color: MColors.ink700,
                        )),
                    const SizedBox(width: 8),
                    Text('• VIRA • 312 jobs',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
          MIconButton(
            icon: Icons.call_rounded,
            background: MColors.coral500,
            foreground: MColors.white,
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          MIconButton(
            icon: Icons.chat_bubble_outline_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline();
  @override
  Widget build(BuildContext context) {
    final steps = const [
      ('Request received', true),
      ('Provider matched', true),
      ('En route', false),
      ('Arrived', false),
      ('Service complete', false),
    ];

    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          _TimelineRow(
            label: steps[i].$1,
            done: steps[i].$2,
            isLast: i == steps.length - 1,
          ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.label,
    required this.done,
    required this.isLast,
  });
  final String label;
  final bool done;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: done ? MColors.mint500 : MColors.ink100,
                shape: BoxShape.circle,
              ),
              child: done
                  ? const Icon(Icons.check_rounded,
                      size: 12, color: Colors.white)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 28,
                color: done ? MColors.mint500 : MColors.ink100,
              ),
          ],
        ),
        const SizedBox(width: MSpace.x12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Text(label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: done ? MColors.ink900 : MColors.ink400,
                    )),
          ),
        ),
      ],
    );
  }
}
