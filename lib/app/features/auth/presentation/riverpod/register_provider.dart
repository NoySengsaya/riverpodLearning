import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// form controller and focus
TextEditingController usernameController = TextEditingController();
FocusNode usernameFocus = FocusNode();

TextEditingController nameController = TextEditingController();
FocusNode nameFocus = FocusNode();

TextEditingController phoneController = TextEditingController();
FocusNode phoneFocus = FocusNode();

TextEditingController passwordController = TextEditingController();
FocusNode passwordFocus = FocusNode();

TextEditingController confirmPasswordController = TextEditingController();
FocusNode confirmPasswordFocus = FocusNode();

TextEditingController emailController = TextEditingController();
FocusNode emailFocus = FocusNode();

final regToggleShowPwd = ChangeNotifierProvider<ToggleShowPasswordProvider>(
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
