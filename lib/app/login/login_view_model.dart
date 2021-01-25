import 'package:dndnamer/app/login/login_client.dart';
import 'package:dndnamer/app/login/view/login.dart';
import 'package:dndnamer/values/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class LoginViewModel {
  final ProviderReference ref;
  final client = LoginClient();

  LoginViewModel(this.ref) : super();

  Future<void> goClick(BuildContext context) async {
    if (ref.read(isWaitingLogin).state) return;

    ref.read(isWaitingLogin).state = true;
    final email = ref.read(loginEmailTextController).text;
    final password = ref.read(loginPasswordTextController).text;
    final login = ref.read(isLogin).state;

    if (login) {
      client.signIn(email, password).then((value) {
        ref.read(isWaitingLogin).state = false;
        Navigator.of(context).pushReplacementNamed(Routes.nameGenerator);
      }).catchError((error) {
        ref.read(isWaitingLogin).state = false;
        debugPrint("Error $error");
      });
    } else {
      client.register(email, password).then((value) {
        ref.read(isWaitingLogin).state = false;
        // TODO: Push document
        Navigator.of(context).pushReplacementNamed(Routes.nameGenerator);
      }).catchError((error) {
        ref.read(isWaitingLogin).state = false;
        debugPrint("Error $error");
      });
    }
  }
}
