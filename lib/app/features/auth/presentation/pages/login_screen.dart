import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  // path
  static const path = '/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch provider
    final provider = ref.watch(loginProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text('login page'),
              ),
              TextButton(
                onPressed: ref.read(loginProvider.notifier).login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
