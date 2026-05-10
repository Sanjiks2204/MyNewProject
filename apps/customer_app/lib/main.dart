import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mechzo_design/mechzo_design.dart';

import 'core/routing/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const ProviderScope(child: MechzoCustomerApp()));
}

class MechzoCustomerApp extends ConsumerWidget {
  const MechzoCustomerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Mechzo',
      debugShowCheckedModeBanner: false,
      theme: MTheme.light(),
      darkTheme: MTheme.dark(),
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
