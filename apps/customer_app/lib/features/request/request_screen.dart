import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mechzo_design/mechzo_design.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  int _step = 0;
  String? _problem;
  final _desc = TextEditingController();

  final _problems = const [
    (Icons.local_gas_station_rounded, 'Out of fuel'),
    (Icons.battery_alert_rounded, 'Battery dead'),
    (Icons.tire_repair_rounded, 'Flat tire'),
    (Icons.car_repair_rounded, 'Engine issue'),
    (Icons.electrical_services_rounded, 'Electrical'),
    (Icons.key_rounded, 'Locked out'),
    (Icons.medical_services_rounded, 'Accident'),
    (Icons.more_horiz_rounded, 'Something else'),
  ];

  @override
  void dispose() {
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MScreen(
      scroll: false,
      appBar: MAppBar(
        title: 'Get help',
        leading: Padding(
          padding: const EdgeInsets.all(MSpace.x12),
          child: MIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: () => context.pop(),
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: MSpace.x8),
          _StepIndicator(step: _step),
          const SizedBox(height: MSpace.x24),
          Expanded(
            child: AnimatedSwitcher(
              duration: MMotion.standard,
              switchInCurve: MMotion.easeOut,
              child: _buildStep(),
            ),
          ),
          MButton(
            label: _step < 2 ? 'Continue' : 'Find help now',
            trailing: Icons.arrow_forward_rounded,
            onPressed: _canContinue() ? _next : null,
          ),
          const SizedBox(height: MSpace.x16),
        ],
      ),
    );
  }

  bool _canContinue() {
    switch (_step) {
      case 0:
        return _problem != null;
      case 1:
        return true; // location step — would gate on permission in real app
      case 2:
        return true;
    }
    return false;
  }

  void _next() {
    if (_step < 2) {
      setState(() => _step++);
    } else {
      context.go('/tracking/demo-job-1');
    }
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _ProblemStep(
          key: const ValueKey('problem'),
          problems: _problems,
          selected: _problem,
          onSelect: (p) => setState(() => _problem = p),
        );
      case 1:
        return const _LocationStep(key: ValueKey('location'));
      case 2:
        return _DescriptionStep(
          key: const ValueKey('description'),
          controller: _desc,
        );
    }
    return const SizedBox.shrink();
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.step});
  final int step;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (i) {
        final active = i <= step;
        return Expanded(
          child: AnimatedContainer(
            duration: MMotion.standard,
            margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
            height: 4,
            decoration: BoxDecoration(
              color: active ? MColors.coral500 : MColors.ink100,
              borderRadius: MRadius.all(MRadius.pill),
            ),
          ),
        );
      }),
    );
  }
}

class _ProblemStep extends StatelessWidget {
  const _ProblemStep({
    super.key,
    required this.problems,
    required this.selected,
    required this.onSelect,
  });
  final List<(IconData, String)> problems;
  final String? selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("What's wrong?",
            style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: MSpace.x8),
        Text('Pick the closest match — you can add details next.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: MColors.ink500)),
        const SizedBox(height: MSpace.x20),
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: problems.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.4,
            ),
            itemBuilder: (_, i) {
              final p = problems[i];
              final isSelected = p.$2 == selected;
              return AnimatedContainer(
                duration: MMotion.quick,
                curve: MMotion.easeOut,
                decoration: BoxDecoration(
                  color: isSelected ? MColors.coral500 : MColors.white,
                  borderRadius: MRadius.all(MRadius.l),
                  border: Border.all(
                    color: isSelected ? MColors.coral500 : MColors.ink100,
                  ),
                  boxShadow: isSelected ? MElevation.e2() : MElevation.e0(),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: MRadius.all(MRadius.l),
                  child: InkWell(
                    borderRadius: MRadius.all(MRadius.l),
                    onTap: () => onSelect(p.$2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Icon(p.$1,
                              size: 22,
                              color:
                                  isSelected ? MColors.white : MColors.ink700),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              p.$2,
                              style:
                                  Theme.of(context).textTheme.labelLarge?.copyWith(
                                        color: isSelected
                                            ? MColors.white
                                            : MColors.ink900,
                                      ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LocationStep extends StatelessWidget {
  const _LocationStep({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Where are you?',
            style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: MSpace.x8),
        Text('We use this to find the nearest help.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: MColors.ink500)),
        const SizedBox(height: MSpace.x20),
        MCard(
          padding: const EdgeInsets.all(MSpace.x16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: MColors.coral100,
                  borderRadius: MRadius.all(MRadius.m),
                ),
                child: const Icon(Icons.location_on_rounded,
                    color: MColors.coral500),
              ),
              const SizedBox(width: MSpace.x12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current location',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text('100 Feet Rd, Indiranagar, Bengaluru',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const MStatusPill(
                  label: 'GPS', tone: MStatusTone.success, pulse: true),
            ],
          ),
        ),
        const SizedBox(height: MSpace.x12),
        MButton(
          label: 'Use a different address',
          variant: MButtonVariant.ghost,
          icon: Icons.search_rounded,
          size: MButtonSize.medium,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _DescriptionStep extends StatelessWidget {
  const _DescriptionStep({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Anything else?',
            style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: MSpace.x8),
        Text('Add a quick note. Photos help us send the right person.',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: MColors.ink500)),
        const SizedBox(height: MSpace.x20),
        MTextField(
          controller: controller,
          hint: "e.g. Front-left tire punctured, spare doesn't fit",
          maxLines: 4,
        ),
        const SizedBox(height: MSpace.x16),
        Row(
          children: [
            _PhotoSlot(),
            const SizedBox(width: 12),
            _PhotoSlot(),
            const SizedBox(width: 12),
            _PhotoSlot(),
          ],
        ),
      ],
    );
  }
}

class _PhotoSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: MColors.ink050,
            borderRadius: MRadius.all(MRadius.m),
            border: Border.all(color: MColors.ink100),
          ),
          child: const Center(
            child: Icon(Icons.add_a_photo_outlined, color: MColors.ink400),
          ),
        ),
      ),
    );
  }
}
