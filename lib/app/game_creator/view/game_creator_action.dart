import 'package:dndnamer/app/game_creator/logic/game_creator_view_model.dart';
import 'package:dndnamer/app/game_creator/view/game_creator.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final _viewModel =
    Provider<GameCreatorViewModel>((ref) => GameCreatorViewModel(ref));

class GameCreatorAction extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(children: [
        Expanded(
            child: ElevatedButton(
          onPressed: () async {
            context.read(_viewModel).createClick(context);
          },
          child: Text(
              watch(editGameUuid).state != null
                  ? Strings.saveGame
                  : Strings.createGame,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ))
      ]),
    );
  }
}
