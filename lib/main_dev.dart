import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app.dart';
import 'app/shared/utils/platform_type.dart';
import 'app/shared/utils/state_logger.dart';
import 'env_config.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // init hive
      final appDir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(appDir.path);
      await Hive.openBox('prefs-${Env.envName}');

      // detect platform type
      final platformType = detectPlatformType();

      runApp(
        ProviderScope(
          overrides: [platformTypeProvider.overrideWithValue(platformType)],
          observers: [StateLogger()],
          child: App(
            key: Key('app-${Env.envName}'),
          ),
        ),
      );
    },
    (error, stack) {},
  );
}
