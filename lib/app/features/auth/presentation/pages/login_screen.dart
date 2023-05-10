import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rpod/app/core/api/pocketbase_provider.dart';

import '../riverpod/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  // path
  static const path = '/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch provider
    final provider = ref.watch(pocketbaseProvider);

    final isObsecured = ref.watch(showPasswordProvider).isObsecured;

    OutlineInputBorder myfocusborder() {
      return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 3,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        focusNode: userNameFocusNode,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          label: Text(
                            'username',
                          ),
                          enabledBorder: myfocusborder(),
                          focusedBorder: myfocusborder(),
                          counterText: '',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        focusNode: passwordFocusNode,
                        obscureText: isObsecured!,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          label: Text(
                            'password',
                          ),
                          enabledBorder: myfocusborder(),
                          focusedBorder: myfocusborder(),
                          counterText: '',
                          suffixIcon: InkWell(
                            onTap: ref
                                .read(showPasswordProvider.notifier)
                                .toggleShowPassword,
                            child: Icon(
                              isObsecured == true
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                              color: isObsecured == true
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => ref.read(pocketbaseProvider.notifier).login(
                      usernameController.text.trim(),
                      passwordController.text.trim(),
                    ),
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
