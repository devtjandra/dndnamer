import 'package:dndnamer/app/game_creator/logic/game_creator_view_model.dart';
import 'package:dndnamer/app/game_creator/view/game_creator.dart';
import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/custom_button.dart';
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
            child: CustomButton(
          onTap: () async {
            context.read(_viewModel).createClick(context);
          },
          isLoading: watch(isWaitingGameCreation).state,
          text: watch(editGameUuid).state != null
              ? Strings.saveGame
              : Strings.createGame,
        ))
      ]),
    );
  }
}
