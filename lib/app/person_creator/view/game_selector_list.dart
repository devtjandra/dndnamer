import 'package:dndnamer/app/game_list/view/game_list.dart';
import 'package:dndnamer/app/person_creator/view/person_creator.dart';
import 'package:dndnamer/widgets/selector_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class GameSelectorList extends ConsumerWidget {
  const GameSelectorList();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final games = watch(gameListViewModel.state);

    return Scaffold(
        body: ListView.builder(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, bottom: 24.0, top: 4.0),
            itemBuilder: (context, index) => SelectorItem(
                  text: games[index].title,
                  onTap: () {
                    context.read(personCreatorGame).state = games[index];
                    context.read(personCreatorPanelController).close();
                  },
                ),
            itemCount: games.length));
  }
}
