import 'package:dndnamer/app/game_list/view/game_list.dart';
import 'package:dndnamer/app/home/view/home_drawer.dart';
import 'package:dndnamer/app/name_generator/view/name_generator.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final currentHomeScreen = StateProvider<String>((ref) => Routes.nameGenerator);

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.black87,
                title: Text(
                  _title(watch),
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                )),
            drawer: Drawer(
              child: HomeDrawer(),
            ),
            body: _screen(watch)));
  }

  String _title(ScopedReader watch) {
    switch (watch(currentHomeScreen).state) {
      case Routes.nameGenerator:
        return Strings.title;

      case Routes.gameList:
        return Strings.gameListTitle;

      default:
        return Strings.title;
    }
  }

  Widget _screen(ScopedReader watch) {
    switch (watch(currentHomeScreen).state) {
      case Routes.nameGenerator:
        return NameGenerator();

      case Routes.gameList:
        return GameList();

      default:
        return NameGenerator();
    }
  }
}
