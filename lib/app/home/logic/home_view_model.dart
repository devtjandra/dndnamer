import 'package:dndnamer/app/home/client/home_client.dart';
import 'package:dndnamer/app/home/view/home.dart';
import 'package:dndnamer/app/home/view/home_drawer.dart';
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

  Future<void> nameGenerator(BuildContext context) async {
    Navigator.of(context).pop();
    context.read(currentHomeScreen).state = Routes.nameGenerator;
  }

  Future<void> games(BuildContext context) async {
    Navigator.of(context).pop();
    context.read(currentHomeScreen).state = Routes.gameList;
  }
}
