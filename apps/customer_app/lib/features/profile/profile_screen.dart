import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mechzo_design/mechzo_design.dart';

import '../../core/state/user_state.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(userNameProvider);
    final initial = (name == null || name.isEmpty)
        ? null
        : name.trim().substring(0, 1).toUpperCase();

    return MScreen(
      appBar: const MAppBar(title: 'Account'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: MSpace.x8),
          MCard(
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
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
                              fontSize: 22,
                            ))
                        : const Icon(Icons.person_rounded,
                            color: Colors.white, size: 26),
                  ),
                ),
                const SizedBox(width: MSpace.x12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name ?? 'Add your name',
                          style: Theme.of(context).textTheme.titleLarge),
                      Text('Tap edit to update',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                MIconButton(icon: Icons.edit_rounded, onPressed: () {}),
              ],
            ),
          ),
          const SizedBox(height: MSpace.x24),
          _Section(title: 'Garage', items: const [
            _Item(Icons.directions_car_rounded, 'My vehicles'),
            _Item(Icons.history_rounded, 'Service history'),
            _Item(Icons.receipt_long_rounded, 'Invoices & payments'),
          ]),
          const SizedBox(height: MSpace.x16),
          _Section(title: 'Trust & safety', items: const [
            _Item(Icons.shield_outlined, 'SafeRide contacts'),
            _Item(Icons.verified_user_outlined, 'KYC & ID'),
          ]),
          const SizedBox(height: MSpace.x16),
          _Section(title: 'App', items: const [
            _Item(Icons.notifications_none_rounded, 'Notifications'),
            _Item(Icons.language_rounded, 'Language'),
            _Item(Icons.help_outline_rounded, 'Help & support'),
            _Item(Icons.logout_rounded, 'Sign out', danger: true),
          ]),
        ],
      ),
    );
  }
}

class _Item {
  const _Item(this.icon, this.label, {this.danger = false});
  final IconData icon;
  final String label;
  final bool danger;
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.items});
  final String title;
  final List<_Item> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(title.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: MColors.ink400,
                    letterSpacing: 0.6,
                  )),
        ),
        MCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                _Row(item: items[i]),
                if (i < items.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: MSpace.x16),
                    child: Divider(height: 1),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.item});
  final _Item item;
  @override
  Widget build(BuildContext context) {
    final color = item.danger ? MColors.crimson500 : MColors.ink700;
    return InkWell(
      onTap: () {},
      borderRadius: MRadius.all(MRadius.l),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: MSpace.x16, vertical: MSpace.x16),
        child: Row(
          children: [
            Icon(item.icon, size: 20, color: color),
            const SizedBox(width: 14),
            Expanded(
              child: Text(item.label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: color,
                      )),
            ),
            if (!item.danger)
              const Icon(Icons.chevron_right_rounded, color: MColors.ink300),
          ],
        ),
      ),
    );
  }
}
