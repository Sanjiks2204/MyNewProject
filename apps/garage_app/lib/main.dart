import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mechzo_design/mechzo_design.dart';

void main() => runApp(const ProviderScope(child: GarageApp()));

class GarageApp extends StatelessWidget {
  const GarageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mechzo Garage',
      debugShowCheckedModeBanner: false,
      theme: MTheme.light(),
      darkTheme: MTheme.dark(),
      themeMode: ThemeMode.light,
      home: const GarageHomeScreen(),
    );
  }
}

class GarageHomeScreen extends StatelessWidget {
  const GarageHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MScreen(
      appBar: const MAppBar(
        title: 'Garage queue',
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MSpace.x12),
            child: MStatusPill(
              label: 'Open',
              tone: MStatusTone.success,
              pulse: true,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: MSpace.x16),
          Row(children: const [
            Expanded(child: _Stat(label: 'Open requests', value: '0')),
            SizedBox(width: 12),
            Expanded(child: _Stat(label: 'In progress', value: '0')),
          ]),
          const SizedBox(height: MSpace.x24),
          Text('Incoming requests',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: MSpace.x12),
          MCard(
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
                  child: const Icon(Icons.inbox_rounded,
                      color: MColors.ink400),
                ),
                const SizedBox(height: MSpace.x12),
                Text('Quiet for now',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text('New requests appear here in real time.',
                    style: Theme.of(context).textTheme.bodySmall),
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
