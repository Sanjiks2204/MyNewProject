import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mechzo_design/mechzo_design.dart';

void main() => runApp(const ProviderScope(child: ViraApp()));

class ViraApp extends StatelessWidget {
  const ViraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mechzo VIRA',
      debugShowCheckedModeBanner: false,
      theme: MTheme.light(),
      darkTheme: MTheme.dark(),
      themeMode: ThemeMode.light,
      home: const ViraHomeScreen(),
    );
  }
}

class ViraHomeScreen extends StatefulWidget {
  const ViraHomeScreen({super.key});

  @override
  State<ViraHomeScreen> createState() => _ViraHomeScreenState();
}

class _ViraHomeScreenState extends State<ViraHomeScreen> {
  bool _online = false;

  @override
  Widget build(BuildContext context) {
    return MScreen(
      appBar: MAppBar(
        title: 'VIRA',
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MSpace.x12),
            child: MStatusPill(
              label: _online ? 'Online' : 'Offline',
              tone: _online ? MStatusTone.success : MStatusTone.neutral,
              pulse: _online,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: MSpace.x16),
          MCard(
            padding: const EdgeInsets.all(MSpace.x20),
            background: _online ? MColors.mint100 : null,
            borderColor: _online ? MColors.mint300 : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_online ? "You're ready for jobs" : 'Go online to receive jobs',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: MSpace.x8),
                Text(
                    _online
                        ? 'We will notify you when a customer nearby needs help.'
                        : "We won't send any requests while you're offline.",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: MSpace.x20),
                MButton(
                  label: _online ? 'Go offline' : 'Go online',
                  variant: _online
                      ? MButtonVariant.ghost
                      : MButtonVariant.primary,
                  icon: _online
                      ? Icons.power_settings_new_rounded
                      : Icons.bolt_rounded,
                  onPressed: () => setState(() => _online = !_online),
                ),
              ],
            ),
          ),
          const SizedBox(height: MSpace.x24),
          Row(children: const [
            Expanded(child: _Stat(label: "Today's earnings", value: '₹0')),
            SizedBox(width: 12),
            Expanded(child: _Stat(label: 'Jobs completed', value: '0')),
          ]),
          const SizedBox(height: MSpace.x16),
          const _Stat(label: 'Rating', value: '—'),
          const SizedBox(height: MSpace.x24),
          MCard(
            padding: const EdgeInsets.all(MSpace.x20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: const [
                  Icon(Icons.verified_outlined, color: MColors.coral500),
                  SizedBox(width: 8),
                  Text('Complete KYC',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16)),
                ]),
                const SizedBox(height: 6),
                Text(
                    'Submit your Aadhaar, PAN, and skill certificate to start accepting jobs.',
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: MSpace.x12),
                MButton(
                  label: 'Start verification',
                  variant: MButtonVariant.ghost,
                  size: MButtonSize.medium,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return MCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 6),
          Text(value,
              style: MType.numeric(
                size: 24,
                weight: FontWeight.w700,
                color: MColors.ink900,
              )),
        ],
      ),
    );
  }
}
