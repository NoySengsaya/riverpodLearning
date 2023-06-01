import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:rpod/app/shared/widgets/app_avatar_upload/avatar_upload.dart';

import '../../../../core/api/pocketbase_provider.dart';
import '../riverpod/register_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  // path
  static const path = '/register';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  String? svgCode;
  String initialDiscriminator = math.Random().nextInt(9999).toString();
  String? stringForGenerate;
  bool regButtonEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  void regenerateDiscriminator() {
    initialDiscriminator = math.Random().nextInt(9999).toString();
    stringForGenerate = '${usernameController.text}_$initialDiscriminator';
    debugPrint('string: ==> $stringForGenerate');
    svgCode = RandomAvatarString(stringForGenerate ?? '', trBackground: false);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isObsecured = ref.watch(regToggleShowPwd).isObsecured;

    OutlineInputBorder myfocusborder() {
      return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 3,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: AvatarUpload(
                    radius: 45,
                    child: SvgPicture.string(
                      svgCode ??
                          RandomAvatarString('reg_${DateTime.now().day}'),
                    ),
                    onRefreshPressed: () => regenerateDiscriminator(),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: TextFormField(
                  controller: usernameController,
                  focusNode: usernameFocus,
                  onChanged: (v) {
                    stringForGenerate = '${v}_$initialDiscriminator';
                    svgCode = RandomAvatarString(stringForGenerate ?? '',
                        trBackground: false);
                    if (v.isNotEmpty) {
                      setState(() {});
                    } else {
                      svgCode = RandomAvatarString('reg_${DateTime.now().day}');
                    }
                  },
                  decoration: InputDecoration(
                    label: Text(
                      'Username',
                    ),
                    suffix: Text('_$initialDiscriminator'),
                    enabledBorder: myfocusborder(),
                    focusedBorder: myfocusborder(),
                    counterText: '',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Your username: ',
                        ),
                        TextSpan(
                          text: stringForGenerate,
                          style: const TextStyle(
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: TextFormField(
                  controller: nameController,
                  focusNode: nameFocus,
                  decoration: InputDecoration(
                    label: Text(
                      'Name',
                    ),
                    enabledBorder: myfocusborder(),
                    focusedBorder: myfocusborder(),
                    counterText: '',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: TextFormField(
                  controller: phoneController,
                  focusNode: phoneFocus,
                  decoration: InputDecoration(
                    label: Text(
                      'Phone',
                    ),
                    enabledBorder: myfocusborder(),
                    focusedBorder: myfocusborder(),
                    counterText: '',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: TextFormField(
                  controller: emailController,
                  focusNode: emailFocus,
                  decoration: InputDecoration(
                    label: Text(
                      'E-mail',
                    ),
                    enabledBorder: myfocusborder(),
                    focusedBorder: myfocusborder(),
                    counterText: '',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  focusNode: passwordFocus,
                  obscureText: isObsecured!,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    label: Text(
                      'password',
                    ),
                    enabledBorder: myfocusborder(),
                    focusedBorder: myfocusborder(),
                    counterText: '',
                    suffixIcon: InkWell(
                      onTap: ref
                          .read(regToggleShowPwd.notifier)
                          .toggleShowPassword,
                      child: Icon(
                        isObsecured == true
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                        color: isObsecured == true ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: TextFormField(
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.text,
                  focusNode: confirmPasswordFocus,
                  obscureText: isObsecured,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    label: Text(
                      'Confirm password',
                    ),
                    enabledBorder: myfocusborder(),
                    focusedBorder: myfocusborder(),
                    counterText: '',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              AbsorbPointer(
                absorbing: !regButtonEnabled,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      regButtonEnabled = false;
                    });
                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      await ref.read(pocketbaseProvider.notifier).register(
                            context,
                            username: stringForGenerate != null
                                ? stringForGenerate!
                                : '${usernameController.text}_$initialDiscriminator',
                            name: nameController.text,
                            password: passwordController.text.trim(),
                            passwordConfirm:
                                confirmPasswordController.text.trim(),
                            phone: phoneController.text,
                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('password not match!!!'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
