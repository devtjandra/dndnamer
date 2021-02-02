import 'package:dndnamer/app/game_list/logic/game_list_view_model.dart';
import 'package:dndnamer/app/game_list/view/game_item.dart';
import 'package:dndnamer/models/game.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final gameListViewModel =
    StateNotifierProvider<GameListViewModel>((ref) => GameListViewModel(ref));
final isWaitingGameRefresh = StateProvider<bool>((ref) => false);

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
        body: _list(watch(gameListViewModel.state)));
  }

  Widget _list(List<Game> games) {
    return ListView.builder(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, bottom: 24.0, top: 4.0),
        itemBuilder: (context, index) => GameItem(games[index]),
        itemCount: games.length);
  }
}
