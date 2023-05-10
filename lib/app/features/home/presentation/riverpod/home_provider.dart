import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker/talker.dart';

import '../../../../../dp.dart';
import '../../../../core/routes/router_notifier.dart';
import '../../../../shared/repositories/repositories.dart';

class HomeNotifier extends AutoDisposeAsyncNotifier<void> {
  final t = dp.get<Talker>();

  @override
  build() async {
    final uid = await dp.get<SharedPrefsRepository>().getUid();
  }
}

final homeNotifierProvider =
    AutoDisposeAsyncNotifierProvider<HomeNotifier, void>(
  () => HomeNotifier(),
);
