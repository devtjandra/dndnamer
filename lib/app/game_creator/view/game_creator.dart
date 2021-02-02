import 'package:dndnamer/app/game_creator/logic/game_creator_view_model.dart';
import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final _viewModel =
    Provider<GameCreatorViewModel>((ref) => GameCreatorViewModel(ref));

final gameCreatorTitleTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final gameCreatorDescriptionTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final isWaitingGameCreation = StateProvider<bool>((ref) => false);

class GameCreator extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(Strings.gameCreatorTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            verticalSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                  controller: watch(gameCreatorTitleTextController),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  decoration: const InputDecoration.collapsed(
                      hintText: Strings.title,
                      hintStyle: TextStyle(color: Colors.grey))),
            ),
            verticalSpace(),
            verticalSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: watch(gameCreatorDescriptionTextController),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                decoration: const InputDecoration.collapsed(
                    hintText: "Description",
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
            ),
            verticalSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () async {
                    context.read(_viewModel).createClick(context);
                  },
                  child: const Text(Strings.createGame),
                ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
