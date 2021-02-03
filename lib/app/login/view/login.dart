import 'package:dndnamer/app/login/logic/login_view_model.dart';
import 'package:dndnamer/app/login/view/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final loginViewModel = Provider<LoginViewModel>((ref) => LoginViewModel(ref));

final isWaitingLogin = StateProvider<bool>((ref) => false);
final isLogin = StateProvider<bool>((ref) => true);
final loginEmailTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final loginPasswordTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final loginNameTextController =
    Provider<TextEditingController>((ref) => TextEditingController());

class Login extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SafeArea(
        child: Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: LoginBody()),
    ));
  }
}
