import 'package:flutter/material.dart';

import '../../tokens/spacing.dart';

/// Standard screen shell — handles safe area, padding, scroll.
class MScreen extends StatelessWidget {
  const MScreen({
    super.key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.padding = const EdgeInsets.symmetric(horizontal: MSpace.x20),
    this.scroll = true,
    this.background,
  });

  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final EdgeInsets padding;
  final bool scroll;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final inner = Padding(padding: padding, child: child);
    return Scaffold(
      backgroundColor: background ?? Theme.of(context).scaffoldBackgroundColor,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      body: SafeArea(
        bottom: bottomNavigationBar == null,
        child: scroll ? SingleChildScrollView(child: inner) : inner,
      ),
    );
  }
}
