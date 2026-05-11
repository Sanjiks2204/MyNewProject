import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mechzo_design/mechzo_design.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phone = TextEditingController();
  bool _valid = false;

  void _onChange(String v) {
    final ok = v.length == 10 && int.tryParse(v) != null;
    if (ok != _valid) setState(() => _valid = ok);
  }

  @override
  void dispose() {
    _phone.dispose();
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
          Text("Let's get you moving",
              style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: MSpace.x8),
          Text(
            "Enter your mobile number. We'll send a 6-digit code.",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: MColors.ink500),
          ),
          const SizedBox(height: MSpace.x32),
          MTextField(
            controller: _phone,
            label: 'Mobile number',
            hint: '9876543210',
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            prefix: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('+91',
                      style: MType.numeric(
                          size: 16,
                          weight: FontWeight.w600,
                          color: MColors.ink900)),
                  const SizedBox(width: 8),
                  Container(width: 1, height: 20, color: MColors.ink200),
                ],
              ),
            ),
            onChanged: _onChange,
          ),
          const SizedBox(height: MSpace.x32),
          MButton(
            label: 'Send code',
            trailing: Icons.arrow_forward_rounded,
            onPressed: _valid
                ? () => context.push('/otp?phone=${_phone.text}')
                : null,
          ),
          const SizedBox(height: MSpace.x16),
          Text(
            'By continuing you agree to our Terms and Privacy Policy.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
