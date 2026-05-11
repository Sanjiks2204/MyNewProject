import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mechzo_design/mechzo_design.dart';

import '../../core/state/user_state.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phone});
  final String phone;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _ctrls =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _nodes = List.generate(6, (_) => FocusNode());
  int _resendIn = 30;
  Timer? _timer;
  bool _verifying = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    Future.delayed(const Duration(milliseconds: 200),
        () => _nodes.first.requestFocus());
  }

  void _startTimer() {
    _timer?.cancel();
    _resendIn = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendIn <= 0) {
        t.cancel();
      } else {
        setState(() => _resendIn--);
      }
    });
  }

  String get _code => _ctrls.map((c) => c.text).join();

  Future<void> _verify() async {
    setState(() => _verifying = true);
    await Future.delayed(const Duration(milliseconds: 900)); // simulate API
    if (!mounted) return;
    setState(() => _verifying = false);
    // TODO: when wired to API, branch on isNewUser. For now treat empty
    // name state as new user and prompt for it.
    final container = ProviderScope.containerOf(context, listen: false);
    final hasName = container.read(userNameProvider) != null;
    context.go(hasName ? '/home' : '/name');
  }

  @override
  void dispose() {
    for (final c in _ctrls) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MScreen(
      appBar: MAppBar(
        leading: Padding(
          padding: const EdgeInsets.all(MSpace.x12),
          child: MIconButton(
            icon: Icons.arrow_back_rounded,
            onPressed: () => context.pop(),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: MSpace.x24),
          Text('Enter the code',
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: MSpace.x8),
          Text.rich(
            TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: MColors.ink500),
              children: [
                const TextSpan(text: 'Sent to '),
                TextSpan(
                  text: '+91 ${widget.phone}',
                  style: const TextStyle(
                    color: MColors.ink900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: MSpace.x32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (i) => _OtpBox(
                  controller: _ctrls[i],
                  focusNode: _nodes[i],
                  onChange: (v) {
                    if (v.length == 1 && i < 5) _nodes[i + 1].requestFocus();
                    if (v.isEmpty && i > 0) _nodes[i - 1].requestFocus();
                    if (_code.length == 6) _verify();
                    setState(() {});
                  },
                )),
          ),
          const SizedBox(height: MSpace.x32),
          MButton(
            label: 'Verify',
            loading: _verifying,
            onPressed: _code.length == 6 ? _verify : null,
          ),
          const SizedBox(height: MSpace.x16),
          Center(
            child: _resendIn > 0
                ? Text(
                    "Resend code in 0:${_resendIn.toString().padLeft(2, '0')}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                : TextButton(
                    onPressed: _startTimer,
                    child: const Text('Resend code'),
                  ),
          ),
        ],
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChange,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChange;

  @override
  Widget build(BuildContext context) {
    final hasValue = controller.text.isNotEmpty;
    return AnimatedContainer(
      duration: MMotion.quick,
      curve: MMotion.easeOut,
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: MColors.ink050,
        borderRadius: MRadius.all(MRadius.m),
        border: Border.all(
          color: hasValue ? MColors.coral500 : Colors.transparent,
          width: 1.6,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        cursorColor: MColors.coral500,
        style: MType.numeric(
          size: 22,
          weight: FontWeight.w700,
          color: MColors.ink900,
        ),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          filled: false,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChange,
      ),
    );
  }
}
