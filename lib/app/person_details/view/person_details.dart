import 'package:dndnamer/app/game_details/view/game_details.dart';
import 'package:dndnamer/app/person_creator/view/person_creator.dart';
import 'package:dndnamer/app/person_details/logic/person_details_view_model.dart';
import 'package:dndnamer/config/types.dart';
import 'package:dndnamer/models/person.dart';
import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/horizontal_line.dart';
import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final personDetailsViewModel =
    Provider<PersonDetailsViewModel>((ref) => PersonDetailsViewModel(ref));

final isWaitingPersonDetails = StateProvider<bool>((ref) => false);
final personDetails = StateProvider<Person>((ref) => null);

class PersonDetails extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final person = watch(personDetails).state;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(watch(personDetails).state?.name ?? ""),
          actions: [
            if (person != null) ...[
              IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.read(editPersonUuid).state = person.uuid;
                    context.read(personCreatorGame).state =
                        context.read(gameDetails).state;
                    context.read(personCreatorNameTextController).text =
                        person.name;
                    context.read(personCreatorDescriptionTextController).text =
                        person.description;
                    context.read(personCreatorImportance).state =
                        person.importance;
                    Navigator.of(context).pushNamed(Routes.personCreator);
                  }),
              IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => context
                      .read(personDetailsViewModel)
                      .deletePerson(context))
            ]
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(children: [
            Row(
              children: [
                const Text(Strings.game),
                horizontalSpace(),
                Expanded(
                  child: Text(
                    watch(gameDetails).state?.title ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            verticalSpace(),
            Row(
              children: [
                const Text(Strings.importance),
                horizontalSpace(),
                Expanded(
                  child: Text(
                    importance[person?.importance ?? 0],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            verticalSpace(height: 16.0),
            HorizontalLine(),
            verticalSpace(height: 16.0),
            if (person == null) ...[
              verticalSpace(height: 24.0),
              const ProgressBar(),
              verticalSpace(height: 24.0),
            ] else
              Row(
                children: [
                  Expanded(
                    child: Text(person?.description ?? ""),
                  )
                ],
              ),
          ]),
        )));
  }
}
