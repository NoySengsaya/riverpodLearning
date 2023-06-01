import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}

final splashProvider = AutoDisposeAsyncNotifierProvider<SplashNotifier, void>(
  () => SplashNotifier(),
);
