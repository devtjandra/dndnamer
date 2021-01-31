import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class GameList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return const Scaffold(body: Text("Game list screen"));
  }
}
