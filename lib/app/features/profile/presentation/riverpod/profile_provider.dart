import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rpod/app/core/api/pocketbase_provider.dart';
import 'package:talker/talker.dart';

import '../../../../../dp.dart';
import '../../../../shared/repositories/repositories.dart';

class ProfileNotifier extends AutoDisposeAsyncNotifier<RecordModel?> {
  final t = dp.get<Talker>();

  @override
  FutureOr<RecordModel?> build() async {
    return await fetchUserInfo();
  }

  // fetch user info
  Future<RecordModel?> fetchUserInfo() async {
    try {
      final pbProvider = ref.read(pocketbaseProvider.notifier);
      final record = await dp.get<SharedPrefsRepository>().getAccessModel();

      if (record != null) {
        return pbProvider.fetchUserInfo(record.id);
      } else {
        return null;
      }
    } catch (e) {
      t.error(e);
      rethrow;
    }
  }
}

final profileProvider =
    AutoDisposeAsyncNotifierProvider<ProfileNotifier, RecordModel?>(
  () => ProfileNotifier(),
);
