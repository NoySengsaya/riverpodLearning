import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:talker/talker.dart';

import '../../../../../dp.dart';
import '../../../../../env_config.dart';

class LoginNotifier extends AutoDisposeAsyncNotifier<void> {
  // get login data

  // pocketbase
  final pb = PocketBase(Env.pbUrl);

  final t = dp.get<Talker>();

  @override
  FutureOr<void> build() async {
    // await login();
  }

  // perform login
  Future<void> login() async {
    try {
      final authData = await pb
          .collection('users')
          .authWithPassword('nss3lue', 'p@ssw0rd123');

      t.info(authData);
    } catch (e) {
      t.error(e);
      rethrow;
    }
  }
}

final loginProvider = AutoDisposeAsyncNotifierProvider<LoginNotifier, void>(
  () => LoginNotifier(),
);
