import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:rpod/app/core/api/pocketbase_provider.dart';
import 'package:talker/talker.dart';

import '../../../../../dp.dart';
import '../../../../../env_config.dart';
import '../../../../shared/repositories/repositories.dart';

TextEditingController usernameController = TextEditingController();
FocusNode userNameFocusNode = FocusNode();

TextEditingController passwordController = TextEditingController();
FocusNode passwordFocusNode = FocusNode();

final showPasswordProvider = ChangeNotifierProvider<ToggleShowPasswordProvider>(
  (ref) => ToggleShowPasswordProvider(),
);
// showed password
bool isObsecure = true;

class ToggleShowPasswordProvider extends ChangeNotifier {
  bool? get isObsecured => isObsecure;

  void toggleShowPassword() {
    isObsecure = !isObsecure;

    return notifyListeners();
  }
}
