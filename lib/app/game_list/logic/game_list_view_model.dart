import 'package:dndnamer/app/game_list/client/game_list_client.dart';
import 'package:dndnamer/app/game_list/view/game_list.dart';
import 'package:dndnamer/models/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class GameListViewModel extends StateNotifier<List<Game>> {
  final ProviderReference ref;
  final client = GameListClient();

  GameListViewModel(this.ref) : super([]) {
    Future.delayed(Duration.zero, () => refreshGame());
  }

  Future<void> refreshGame() async {
    if (ref.read(isWaitingGameRefresh).state) return;

    ref.read(isWaitingGameRefresh).state = true;

    client.getGames().then((value) {
      debugPrint("Games retrieved $value");
      state = value;
      ref.read(isWaitingGameRefresh).state = false;
    }).catchError((error) {
      state = [];
      ref.read(isWaitingGameRefresh).state = false;
      debugPrint("Error $error");
    });
  }
}
