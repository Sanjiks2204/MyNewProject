import 'package:flutter/material.dart';

import '../../tokens/spacing.dart';

class MAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions = const [],
    this.background,
  });

  final String? title;
  final Widget? leading;
  final List<Widget> actions;
  final Color? background;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: background ?? theme.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: MSpace.x16,
      leading: leading,
      title: title == null
          ? null
          : Text(
              title!,
              style: theme.textTheme.headlineMedium,
            ),
      actions: [
        ...actions,
        const SizedBox(width: MSpace.x8),
      ],
    );
  }
}
