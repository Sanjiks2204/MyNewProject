import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/name_screen.dart';
import '../../features/auth/otp_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/request/request_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/tracking/tracking_screen.dart';
import 'page_transitions.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (_, state) => fadePage(state, const SplashScreen()),
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (_, state) => slidePage(state, const OnboardingScreen()),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (_, state) => slidePage(state, const LoginScreen()),
      ),
      GoRoute(
        path: '/otp',
        pageBuilder: (_, state) {
          final phone = state.uri.queryParameters['phone'] ?? '';
          return slidePage(state, OtpScreen(phone: phone));
        },
      ),
      GoRoute(
        path: '/name',
        pageBuilder: (_, state) => slidePage(state, const NameScreen()),
      ),
      GoRoute(
        path: '/home',
        pageBuilder: (_, state) => fadePage(state, const HomeScreen()),
      ),
      GoRoute(
        path: '/request',
        pageBuilder: (_, state) => slidePage(state, const RequestScreen()),
      ),
      GoRoute(
        path: '/tracking/:jobId',
        pageBuilder: (_, state) {
          final id = state.pathParameters['jobId']!;
          return slidePage(state, TrackingScreen(jobId: id));
        },
      ),
    ],
  );
});
