import 'package:dndnamer/app/login/logic/login_view_model.dart';
import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:dndnamer/widgets/switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final loginViewModel = Provider<LoginViewModel>((ref) => LoginViewModel(ref));

final isWaitingLogin = StateProvider<bool>((ref) => false);
final isLogin = StateProvider<bool>((ref) => false);
final loginEmailTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final loginPasswordTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final loginNameTextController =
    Provider<TextEditingController>((ref) => TextEditingController());

final _description = Provider<String>((ref) => ref.watch(isLogin).state
    ? Strings.loginDescription
    : Strings.registrationDescription);

class Login extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Switcher(
            options: const [Strings.login, Strings.registration],
            selectedIndex: watch(isLogin).state ? 0 : 1,
            onItemSelected: (index) => context.read(isLogin).state = index == 0,
          ),
          verticalSpace(),
          Text(watch(_description), style: Styles.descriptionText),
          verticalSpace(),
          TextField(
              controller: watch(loginEmailTextController),
              decoration: const InputDecoration.collapsed(
                  hintText: Strings.email, hintStyle: Styles.hintText)),
          verticalSpace(),
          TextField(
              controller: watch(loginPasswordTextController),
              obscureText: true,
              decoration: const InputDecoration.collapsed(
                  hintText: Strings.email, hintStyle: Styles.hintText)),
          verticalSpace(),
          TextField(
              controller: watch(loginNameTextController),
              obscureText: true,
              decoration: const InputDecoration.collapsed(
                  hintText: Strings.name, hintStyle: Styles.hintText)),
          if (watch(isWaitingLogin).state) ...[
            verticalSpace(),
            const ProgressBar()
          ],
          verticalSpace(),
          OutlineButton(
              onPressed: () => context.read(loginViewModel).goClick(context),
              child:
                  Text(watch(isLogin).state ? Strings.login : Strings.register))
        ],
      )),
    );
  }
}
