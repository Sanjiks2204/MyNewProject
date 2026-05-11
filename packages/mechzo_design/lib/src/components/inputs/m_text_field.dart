import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';

class MTextField extends StatelessWidget {
  const MTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.helper,
    this.error,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.inputFormatters,
    this.obscure = false,
    this.maxLength,
    this.maxLines = 1,
    this.onChanged,
    this.autofocus = false,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? helper;
  final String? error;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscure;
  final int? maxLength;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: theme.textTheme.labelMedium),
          const SizedBox(height: MSpace.x8),
        ],
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscure,
          maxLength: maxLength,
          maxLines: maxLines,
          onChanged: onChanged,
          autofocus: autofocus,
          enabled: enabled,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefix,
            suffixIcon: suffix,
            counterText: '',
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: MSpace.x4),
          Text(error!,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: MColors.crimson500)),
        ] else if (helper != null) ...[
          const SizedBox(height: MSpace.x4),
          Text(helper!, style: theme.textTheme.bodySmall),
        ]
      ],
    );
  }
}
