import 'package:dndnamer/app/splash/client/splash_client.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class SplashViewModel {
  final ProviderReference ref;
  final client = SplashClient();

  SplashViewModel(this.ref) : super();

  void initialise(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 200), () async {
      final isLoggedIn = await client.loginCheck();
      final route = isLoggedIn ? Routes.nameGenerator : Routes.login;
      Navigator.of(context).pushReplacementNamed(route);
    });
  }
}
