// ignore_for_file: avoid_single_cascade_in_expression_statements

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:talker/talker.dart';

import 'app/shared/repositories/repositories.dart';

final dp = GetIt.instance;

void dpInit() {
  dp

    /// register shared preferences
    ..registerLazySingleton<SharedPrefsRepository>(
      () => SharedPrefsRepositoryImpl(dp()),
    )

    /// register flutter secure storage
    ..registerLazySingleton<SecureStorageRepository>(
      () => SecureStorageRepositoryImpl(
        storage: const FlutterSecureStorage(),
      ),
    )

    // register talker for logging
    ..registerLazySingleton<Talker>(() => Talker());
}
