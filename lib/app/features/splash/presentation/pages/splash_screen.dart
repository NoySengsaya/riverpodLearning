import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/splash_screen.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  // path
  static const path = '/splash';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(splashProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: Text('Splash Loading'),
            )
          ],
        ),
      ),
    );
  }
}
