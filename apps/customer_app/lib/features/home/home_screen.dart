import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mechzo_design/mechzo_design.dart';

import '../../core/state/user_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: MColors.ink050,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Header(),
              const SizedBox(height: MSpace.x16),
              const _EmergencyCard(),
              const SizedBox(height: MSpace.x24),
              const _SectionTitle('What do you need?'),
              const SizedBox(height: MSpace.x12),
              _Services(onTap: () => context.push('/request')),
              const SizedBox(height: MSpace.x32),
              const _SectionTitle('Your vehicle'),
              const SizedBox(height: MSpace.x12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: MSpace.x20),
                child: _VehicleCard(),
              ),
              const SizedBox(height: MSpace.x32),
              const _SectionTitle('Recent activity'),
              const SizedBox(height: MSpace.x12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: MSpace.x20),
                child: _EmptyActivity(),
              ),
              const SizedBox(height: MSpace.x40),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(userNameProvider);
    final initial = (name == null || name.isEmpty)
        ? null
        : name.trim().substring(0, 1).toUpperCase();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
          MSpace.x20, MSpace.x16, MSpace.x20, MSpace.x16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: MColors.coralGradient,
              borderRadius: MRadius.all(MRadius.pill),
            ),
            child: Center(
              child: initial != null
                  ? Text(initial,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ))
                  : const Icon(Icons.person_rounded,
                      color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(width: MSpace.x12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(greetingForNow(),
                    style: Theme.of(context).textTheme.bodyMedium),
                Text(name ?? 'Welcome',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
          const MIconButton(icon: Icons.notifications_none_rounded),
        ],
      ),
    );
  }
}

class _EmergencyCard extends StatelessWidget {
  const _EmergencyCard();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MSpace.x20),
      child: Container(
        padding: const EdgeInsets.all(MSpace.x20),
        decoration: BoxDecoration(
          gradient: MColors.heroGradient,
          borderRadius: MRadius.all(MRadius.xl),
          boxShadow: MElevation.e3(),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: MColors.coral500.withOpacity(0.2),
                    borderRadius: MRadius.all(MRadius.pill),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: const [
                    MPulseDot(color: MColors.coral500, size: 6),
                    SizedBox(width: 6),
                    Text('Live support',
                        style: TextStyle(
                          color: MColors.coral200,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        )),
                  ]),
                ),
                const Spacer(),
                Text('24/7',
                    style: MType.numeric(
                      size: 13,
                      weight: FontWeight.w600,
                      color: MColors.ink200,
                    )),
              ],
            ),
            const SizedBox(height: MSpace.x16),
            Text(
              'Broken down?\nHelp is one tap away.',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: MColors.white, height: 1.2),
            ),
            const SizedBox(height: MSpace.x20),
            MButton(
              label: 'Get help now',
              variant: MButtonVariant.secondary,
              size: MButtonSize.medium,
              icon: Icons.bolt_rounded,
              expand: false,
              onPressed: () => GoRouter.of(context).push('/request'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MSpace.x20),
      child: Text(text, style: Theme.of(context).textTheme.headlineMedium),
    );
  }
}

class _Services extends StatelessWidget {
  const _Services({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final services = [
      (Icons.local_gas_station_rounded, 'Fuel', MColors.amber500),
      (Icons.battery_charging_full_rounded, 'Battery', MColors.mint500),
      (Icons.tire_repair_rounded, 'Flat tire', MColors.coral500),
      (Icons.car_repair_rounded, 'Engine', MColors.ink700),
      (Icons.key_rounded, 'Locked out', MColors.amber500),
      (Icons.medical_services_rounded, 'Accident', MColors.crimson500),
      (Icons.electrical_services_rounded, 'Electrical', MColors.mint500),
      (Icons.more_horiz_rounded, 'Other', MColors.ink500),
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: MSpace.x20),
        separatorBuilder: (_, __) => const SizedBox(width: MSpace.x12),
        itemCount: services.length,
        itemBuilder: (_, i) {
          final s = services[i];
          return _ServiceTile(icon: s.$1, label: s.$2, color: s.$3, onTap: onTap);
        },
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 92,
        padding: const EdgeInsets.symmetric(vertical: MSpace.x12),
        decoration: BoxDecoration(
          color: MColors.white,
          borderRadius: MRadius.all(MRadius.l),
          border: Border.all(color: MColors.ink100),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: MRadius.all(MRadius.m),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 8),
            Text(label,
                style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard();
  @override
  Widget build(BuildContext context) {
    return MCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: MColors.ink050,
              borderRadius: MRadius.all(MRadius.m),
            ),
            child: const Icon(Icons.directions_car_rounded,
                color: MColors.ink700),
          ),
          const SizedBox(width: MSpace.x12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Maruti Swift VXi',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text('KA 05 MZ 1234 • Petrol',
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const MStatusPill(
            label: 'Verified',
            tone: MStatusTone.success,
            icon: Icons.verified_rounded,
          ),
        ],
      ),
    );
  }
}

class _EmptyActivity extends StatelessWidget {
  const _EmptyActivity();
  @override
  Widget build(BuildContext context) {
    return MCard(
      padding: const EdgeInsets.symmetric(
          horizontal: MSpace.x20, vertical: MSpace.x32),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: MColors.ink050,
              borderRadius: MRadius.all(MRadius.pill),
            ),
            child: const Icon(Icons.history_rounded,
                color: MColors.ink400),
          ),
          const SizedBox(height: MSpace.x12),
          Text('No trips yet',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text("Your service history will appear here.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
