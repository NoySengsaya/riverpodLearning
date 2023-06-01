import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rpod/app/features/home/home.dart';
import 'package:rpod/env_config.dart';
import 'package:talker/talker.dart';

import '../../../dp.dart';
import '../../shared/repositories/repositories.dart';

class PocketBaseProvider extends AutoDisposeAsyncNotifier<String?> {
  // talker logger
  final t = dp.get<Talker>();

  // user collection
  final usrCOLLECTION = 'users';
  final feedsCOLLECTION = 'feeds';

  String _userName = '';

  // health check
  Timer? _healthCheckTimer;
  bool _lastHealthy = true;
  bool _healthy = true;

  final PocketBase pb = PocketBase(
    Env.pbUrl,
  );

  // getter
  bool get isAuth => pb.authStore.isValid && pb.authStore.token.isNotEmpty;
  String get userName => _userName;

  @override
  FutureOr<String?> build() async {
    return await loginRecovery();
  }

  /// login with `users` collection
  ///
  /// perform login
  Future<void> login(String name, String password) async {
    try {
      t.info('loggin in as: ==> $name $password');
      final authData =
          await pb.collection('users').authWithPassword(name, password);

      t.info('auth data: ==> $authData');
      _healthy = true;
      _userName = authData.record?.data['name'].toString() ?? '';

      // save token
      await dp.get<SharedPrefsRepository>().saveToken(pb.authStore.token);
      await dp.get<SharedPrefsRepository>().saveAccessModel(pb.authStore.model);

      state = AsyncValue.data(pb.authStore.token);
    } catch (e) {
      t.error(e);
      rethrow;
    }
  }

  /// auto login recovery
  ///
  /// perform auto login
  Future<String?> loginRecovery() async {
    try {
      final token = await dp.get<SharedPrefsRepository>().getToken();
      final model = await dp.get<SharedPrefsRepository>().getAccessModel();

      t
        ..info('token: ==> $token')
        ..info('model: ==> $model');

      if (model != null) {
        pb.authStore.save(token, model);

        // if auth store confirm to pocketbase is invalid logged out
        if (!pb.authStore.isValid) {
          state = const AsyncValue.data(null);
          return null;
        }

        ensureKeepAlive();

        state = AsyncValue.data(token);
        return pb.authStore.token;
      } else {
        t.info('model == null');
        state = const AsyncValue.data(null);
        return null;
      }
    } catch (e) {
      t.error(e);
      rethrow;
    }
  }

  /// logout
  ///
  /// perform log out
  Future<void> logout() async {
    try {
      await dp.get<SharedPrefsRepository>().deleteAll();
      await dp.get<SecureStorageRepository>().deleteAll();

      state = const AsyncValue.data(null);
    } catch (e) {
      rethrow;
    }
  }

  /// register
  ///
  /// perform user registrations
  Future<void> register(
    BuildContext context, {
    required String username,
    String? name,
    required String password,
    required String passwordConfirm,
    String? email,
    String? phone,
    String? avatar,
  }) async {
    try {
      final data = {
        "username": username,
        "email": email ?? '',
        "emailVisibility": true,
        "password": password,
        "passwordConfirm": passwordConfirm,
        "name": name,
        "phone": phone,
      };

      final record = await pb.collection('users').create(body: data);

      t.info('registered record: ==> ${record.data}');

      // (optional) send an email verification request
      if (email != null) {
        await pb.collection('users').requestVerification(email);
      }

      await login(username, password);
    } catch (e) {
      t.error('error: ==> ${e}');
      rethrow;
    }
  }

  Future<void> doHealthCheck() async {
    pb.health.check().then((value) {
      _healthy = true;
    }).onError((error, stackTrace) {
      _healthy = false;
    }).whenComplete(() {
      if (_healthy != _lastHealthy) {
        t.info('h: ====> $_healthy');
      }
      _lastHealthy = _healthy;
    });
  }

  Future<void> ensureKeepAlive() async {
    _healthCheckTimer?.cancel();
    _healthCheckTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      doHealthCheck();
    });
  }

  Future<RecordModel?> fetchUserInfo(String recordID) async {
    try {
      final info = await pb.collection(usrCOLLECTION).getOne(recordID);
      return info;
    } catch (e) {
      t.error(e);
      rethrow;
    }
  }
}

final pocketbaseProvider =
    AutoDisposeAsyncNotifierProvider<PocketBaseProvider, String?>(
  () => PocketBaseProvider(),
);
