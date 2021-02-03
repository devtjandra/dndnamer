import 'package:dndnamer/app/login/client/login_client.dart';
import 'package:dndnamer/app/login/view/login.dart';
import 'package:dndnamer/utils/snack.dart';
import 'package:dndnamer/values/routes.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class LoginViewModel {
  final ProviderReference ref;
  final client = LoginClient();

  LoginViewModel(this.ref) : super();

  Future<void> goClick(BuildContext context) async {
    if (ref.read(isWaitingLogin).state) return;

    final email = ref.read(loginEmailTextController).text;
    final password = ref.read(loginPasswordTextController).text;
    final login = ref.read(isLogin).state;

    if (email.isEmpty || password.isEmpty) {
      Snack.showFieldErrorSnack(context);
      return;
    }
    
    ref.read(isWaitingLogin).state = true;

    if (login) {
      client.signIn(email, password).then((value) {
        ref.read(isWaitingLogin).state = false;
        _done(context);
      }).catchError((error) {
        ref.read(isWaitingLogin).state = false;
        debugPrint("Error $error");
      });
    } else {
      final name = ref.read(loginNameTextController).text;
      if (name.isEmpty) {
        Snack.showFieldErrorSnack(context);
        return;
      }
      client.register(email, password, name).then((value) {
        ref.read(isWaitingLogin).state = false;
        _done(context);
      }).catchError((error) {
        ref.read(isWaitingLogin).state = false;
        debugPrint("Error $error");
      });
    }
  }

  void _done(BuildContext context) {
    ref.read(loginEmailTextController).text = "";
    ref.read(loginPasswordTextController).text = "";
    ref.read(loginNameTextController).text = "";
    ref.read(isLogin).state = true;
    Navigator.of(context).pushReplacementNamed(Routes.home);
  }
}
