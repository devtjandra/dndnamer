import 'package:dndnamer/app/game_details/logic/game_details_view_model.dart';
import 'package:dndnamer/app/game_details/view/person_list_item.dart';
import 'package:dndnamer/models/game.dart';
import 'package:dndnamer/models/person.dart';
import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/horizontal_line.dart';
import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final gameDetailsViewModel =
    Provider<GameDetailsViewModel>((ref) => GameDetailsViewModel(ref));

final isWaitingGameDetails = StateProvider<bool>((ref) => false);
final isWaitingPersonsList = StateProvider<bool>((ref) => false);
final gameDetails = StateProvider<Game>((ref) => null);
final personsList = StateProvider<List<Person>>((ref) => []);

class GameDetails extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final persons = watch(personsList).state;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(watch(gameDetails).state?.title ?? ""),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(children: [
            if (watch(isWaitingGameDetails).state)
              const ProgressBar()
            else
              Row(
                children: [
                  Expanded(
                    child: Text(watch(gameDetails).state?.description ?? ""),
                  )
                ],
              ),
            verticalSpace(),
            HorizontalLine(),
            verticalSpace(),
            const Text(
              Strings.characters,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            verticalSpace(),
            if (watch(isWaitingPersonsList).state)
              const ProgressBar()
            else if (persons.isEmpty)
              const Text(Strings.emptyPersons)
            else
              ...persons
                  .map((element) => PersonListItem(
                      text: element.name,
                      onTap: () {
                        // TODO: Go to person details screen
                      }))
                  .toList()
          ]),
        )));
  }
}
