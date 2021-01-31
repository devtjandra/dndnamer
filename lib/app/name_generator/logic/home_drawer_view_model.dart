import 'package:dndnamer/app/name_generator/client/home_drawer_client.dart';
import 'package:dndnamer/app/name_generator/view/home_drawer.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class HomeDrawerViewModel {
  final client = HomeDrawerClient();
  final ProviderReference ref;

  HomeDrawerViewModel(this.ref) : super();

  Future<void> signOut(BuildContext context) async {
    ref.read(isWaitingLogout).state = true;
    await client.signOut();
    ref.read(isWaitingLogout).state = false;

    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(Routes.splash);
  }
}
