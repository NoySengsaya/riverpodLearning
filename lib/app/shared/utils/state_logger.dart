import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../../dp.dart';

class StateLogger extends ProviderObserver {
  final t = dp.get<Talker>();

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    if (newValue is StateController<int>) {
      if (kDebugMode) {
        t.info(
          '[${provider.name ?? provider.runtimeType}] value: ${newValue.state}',
        );
      }
    }
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }
}
