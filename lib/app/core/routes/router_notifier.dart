import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rpod/app/core/api/pocketbase_provider.dart';
import 'package:talker/talker.dart';

import '../../../dp.dart';
import '../../features/auth/auth.dart';
import '../../features/auth/presentation/riverpod/login_provider.dart';
import '../../features/feeds/feeds.dart';
import '../../features/home/home.dart';
import '../../features/profile/profile.dart';
import '../../features/splash/splash.dart';
import '../../shared/repositories/repositories.dart';

class RouterNotifier extends AutoDisposeAsyncNotifier<void>
    implements Listenable {
  VoidCallback? routerListener;
  bool isAuth = false;

  final t = dp.get<Talker>();

  @override
  FutureOr<void> build() async {
    isAuth = await ref.watch(pocketbaseProvider.selectAsync((data) {
      if (data != null) {
        return true;
      } else {
        return false;
      }
    }));

    ref.listenSelf((_, __) {
      // One could write more conditional logic for when to call redirection
      if (state.isLoading) return;
      routerListener?.call();
    });
  }

  /// Redirects the user when our authentication changes
  String? redirect(BuildContext context, GoRouterState state) {
    /// redirect none if state == null
    if (this.state.isLoading || this.state.hasError) return null;

    // login location
    final loginLocation = state.location == LoginScreen.path;

    // splash location
    final splashLocation = state.location == SplashScreen.path;

    // home location
    final homeLocation = state.location == HomeScreen.path;

    // redirect from splash location
    if (splashLocation) {
      return isAuth ? HomeScreen.path : LoginScreen.path;
    }

    // redirect from login location
    else if (loginLocation) {
      return isAuth ? HomeScreen.path : LoginScreen.path;
    }
    // redirect from home location on logout

    else if (homeLocation) {
      return isAuth ? HomeScreen.path : LoginScreen.path;
    } else {
      return null;
    }
  }

  /// all available app routes
  ///
  /// `<GoRoute>[]`
  List<GoRoute> get routes => [
        GoRoute(
          path: SplashScreen.path,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: LoginScreen.path,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: RegisterScreen.path,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: HomeScreen.path,
          builder: (context, state) => const HomeScreen(),
        ),

        // feeds
        GoRoute(
          path: FeedsScreen.path,
          builder: (context, state) => const FeedsScreen(),
        ),

        // profile
        GoRoute(
          path: ProfileScreen.path,
          builder: (context, state) => const ProfileScreen(),
        ),
      ];

  /// Adds [GoRouter]'s listener as specified by its [Listenable]
  /// [GoRouteInformationProvider] uses this method on creation to handle its
  /// internal [ChangeNotifier].
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void addListener(VoidCallback listener) {
    routerListener = listener;
  }

  /// Removes [GoRouter]'s listener as specified by its [Listenable].
  /// [GoRouteInformationProvider] uses this method when disposing,
  /// so that it removes its callback when destroyed.
  /// Check out the internal implementation of [GoRouter] and
  /// [GoRouteInformationProvider] to see this in action.
  @override
  void removeListener(VoidCallback listener) {
    routerListener = null;
  }
}

final routerNotifier = AutoDisposeAsyncNotifierProvider<RouterNotifier, void>(
  () => RouterNotifier(),
);
