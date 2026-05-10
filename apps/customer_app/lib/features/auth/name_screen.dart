import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mechzo_design/mechzo_design.dart';

import '../../core/state/user_state.dart';

class NameScreen extends ConsumerStatefulWidget {
  const NameScreen({super.key});

  @override
  ConsumerState<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends ConsumerState<NameScreen> {
  final _ctrl = TextEditingController();
  bool _valid = false;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _ctrl.text.trim();
    if (name.isEmpty) return;
    ref.read(userNameProvider.notifier).state = name;
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return MScreen(
      appBar: const MAppBar(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: MSpace.x8),
          Text("What should we call you?",
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: MSpace.x8),
          Text(
            "We'll use this to greet you and let providers know who to look for.",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: MColors.ink500),
          ),
          const SizedBox(height: MSpace.x32),
          MTextField(
            controller: _ctrl,
            label: 'Your name',
            hint: 'Your full name',
            autofocus: true,
            onChanged: (v) {
              final ok = v.trim().length >= 2;
              if (ok != _valid) setState(() => _valid = ok);
            },
          ),
          const SizedBox(height: MSpace.x32),
          MButton(
            label: 'Continue',
            trailing: Icons.arrow_forward_rounded,
            onPressed: _valid ? _submit : null,
          ),
        ],
      ),
    );
  }
}
