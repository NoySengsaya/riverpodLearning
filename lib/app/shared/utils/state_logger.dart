import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../../dp.dart';

final t = dp.get<Talker>();

class StateLogger extends ProviderObserver {
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
