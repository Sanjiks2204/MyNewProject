import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mechzo_design/mechzo_design.dart';

CustomTransitionPage<T> fadePage<T>(GoRouterState state, Widget child) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: MMotion.standard,
    transitionsBuilder: (_, animation, __, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: MMotion.easeOut),
        child: child,
      );
    },
  );
}

CustomTransitionPage<T> slidePage<T>(GoRouterState state, Widget child) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: MMotion.expressive,
    transitionsBuilder: (_, animation, __, child) {
      final offset = Tween<Offset>(
        begin: const Offset(0, 0.04),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: MMotion.spring));
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: MMotion.easeOut),
        child: SlideTransition(position: offset, child: child),
      );
    },
  );
}
