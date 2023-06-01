import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../env_config.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../shared/widgets/widgets.dart';
import 'router_notifier.dart';

final key = GlobalKey<NavigatorState>(debugLabel: '${Env.envName}-router-key');

final routerProvider = Provider.autoDispose<GoRouter>((ref) {
  // router notifier
  final notifier = ref.watch(routerNotifier.notifier);

  return GoRouter(
    navigatorKey: key,
    refreshListenable: notifier,
    debugLogDiagnostics: kDebugMode,
    initialLocation: SplashScreen.path,
    routes: notifier.routes,
    redirect: notifier.redirect,
    errorBuilder: (context, state) => const ErrorRouterWidget(),
  );
});
