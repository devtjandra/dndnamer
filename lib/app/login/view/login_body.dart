import 'package:dndnamer/app/login/view/login.dart';
import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:dndnamer/widgets/switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final _description = Provider<String>((ref) => ref.watch(isLogin).state
    ? Strings.loginDescription
    : Strings.registrationDescription);

class LoginBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Switcher(
          options: const [Strings.login, Strings.registration],
          selectedIndex: watch(isLogin).state ? 0 : 1,
          onItemSelected: (index) => context.read(isLogin).state = index == 0,
        ),
        verticalSpace(),
        Text(watch(_description), style: Styles.descriptionText),
        verticalSpace(),
        ..._form(watch),
        verticalSpace(),
        OutlineButton(
            onPressed: () => context.read(loginViewModel).goClick(context),
            child:
                Text(watch(isLogin).state ? Strings.login : Strings.register))
      ],
    );
  }

  List<Widget> _form(ScopedReader watch) {
    return [
      TextField(
          controller: watch(loginEmailTextController),
          decoration: const InputDecoration.collapsed(
              hintText: Strings.email, hintStyle: Styles.hintText)),
      verticalSpace(),
      TextField(
          controller: watch(loginPasswordTextController),
          obscureText: true,
          decoration: const InputDecoration.collapsed(
              hintText: Strings.password, hintStyle: Styles.hintText)),
      verticalSpace(),
      if (!watch(isLogin).state)
        TextField(
            controller: watch(loginNameTextController),
            decoration: const InputDecoration.collapsed(
                hintText: Strings.name, hintStyle: Styles.hintText)),
      if (watch(isWaitingLogin).state) ...[
        verticalSpace(),
        const ProgressBar()
      ],
    ];
  }
}
