import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class GameList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).pushNamed(Routes.gameCreator),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: const Text("Game list screen"));
  }
}
