import 'package:dndnamer/app/person_creator/view/game_selector_list.dart';
import 'package:dndnamer/app/person_creator/view/person_creator_body.dart';
import 'package:dndnamer/models/game.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final personCreatorPanelController =
    Provider<PanelController>((ref) => PanelController());
final personCreatorNameTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final personCreatorDescriptionTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final personCreatorImportance = StateProvider<int>((ref) => 0);
final personCreatorGame = StateProvider<Game>((ref) => null);
final isWaitingPersonCreation = StateProvider<bool>((ref) => false);
final editPersonUuid = StateProvider<String>((ref) => null);

class PersonCreator extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
        appBar: AppBar(
          title: Text(watch(editPersonUuid).state != null
              ? Strings.personCreatorEditTitle
              : Strings.personCreatorTitle),
        ),
        body: Stack(children: [
          PersonCreatorBody(),
          SlidingUpPanel(
              minHeight: 0.0,
              maxHeight: 350.0,
              panel: const GameSelectorList(),
              controller: watch(personCreatorPanelController),
              body: Container())
        ]));
  }
}
