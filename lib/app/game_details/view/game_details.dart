import 'package:dndnamer/app/game_details/logic/game_details_view_model.dart';
import 'package:dndnamer/app/game_details/view/person_list_item.dart';
import 'package:dndnamer/app/game_list/view/game_list.dart';
import 'package:dndnamer/app/person_creator/view/person_creator.dart';
import 'package:dndnamer/app/person_details/view/person_details.dart';
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
final isWaitingPersonDelete = StateProvider<String>((ref) => null);

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
          actions: [
            if (watch(isWaitingGameDelete).state != null)
              const ProgressBar()
            else
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () =>
                      context.read(gameDetailsViewModel).deleteGame(context))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read(personCreatorGame).state =
                context.read(gameDetails).state;
            context.read(editPersonUuid).state = null;
            context.read(personCreatorNameTextController).text = "";
            context.read(personCreatorDescriptionTextController).text = "";
            context.read(personCreatorImportance).state = 0;

            Navigator.pushNamed(context, Routes.personCreator);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(children: [
            if (watch(isWaitingGameDetails).state) ...[
              verticalSpace(height: 24.0),
              const ProgressBar(),
              verticalSpace(height: 24.0),
            ] else
              Row(
                children: [
                  Expanded(
                    child: Text(watch(gameDetails).state?.description ?? ""),
                  )
                ],
              ),
            verticalSpace(height: 16.0),
            HorizontalLine(),
            verticalSpace(height: 16.0),
            const Text(
              Strings.characters,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            verticalSpace(),
            if (watch(isWaitingPersonsList).state) ...[
              verticalSpace(height: 24.0),
              const ProgressBar(),
              verticalSpace(height: 24.0),
            ] else if (persons.isEmpty)
              const Text(Strings.emptyPersons)
            else
              ...persons
                  .map((element) => PersonListItem(
                        person: element,
                        onTap: () {
                          context
                              .read(personDetailsViewModel)
                              .getPerson(element.uuid);
                          Navigator.of(context).pushNamed(Routes.personDetails);
                        },
                        onEdit: () {
                          context.read(editPersonUuid).state = element.uuid;
                          context.read(personCreatorGame).state =
                              context.read(gameDetails).state;
                          context.read(personCreatorNameTextController).text =
                              element.name;
                          context
                              .read(personCreatorDescriptionTextController)
                              .text = element.description;
                          context.read(personCreatorImportance).state =
                              element.importance;

                          Navigator.pushNamed(context, Routes.personCreator);
                        },
                        onDelete: () => context
                            .read(gameDetailsViewModel)
                            .deletePerson(element.uuid),
                      ))
                  .toList()
          ]),
        )));
  }
}
