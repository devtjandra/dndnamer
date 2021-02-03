import 'package:dndnamer/app/person_creator/logic/person_creator_view_model.dart';
import 'package:dndnamer/app/person_creator/view/person_creator.dart';
import 'package:dndnamer/config/types.dart';
import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final _viewModel =
    Provider<PersonCreatorViewModel>((ref) => PersonCreatorViewModel(ref));

class PersonCreatorBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                  onPressed: () =>
                      context.read(personCreatorPanelController).open(),
                  child: Text(
                    watch(personCreatorGame).state?.title ?? Strings.emptyGame,
                    style: const TextStyle(color: Colors.white),
                  ),
                ))
              ],
            ),
            verticalSpace(),
            verticalSpace(),
            TextField(
                controller: watch(personCreatorNameTextController),
                style: const TextStyle(fontWeight: FontWeight.bold),
                decoration: const InputDecoration.collapsed(
                    hintText: Strings.name,
                    hintStyle: TextStyle(color: Colors.grey))),
            verticalSpace(),
            verticalSpace(),
            TextField(
              controller: watch(personCreatorDescriptionTextController),
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              decoration: const InputDecoration.collapsed(
                  hintText: Strings.description,
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            Slider(
              value: watch(personCreatorImportance).state.toDouble(),
              max: 3,
              divisions: 3,
              label: importance[watch(personCreatorImportance).state],
              onChanged: (double value) =>
                  context.read(personCreatorImportance).state = value.toInt(),
            ),
            if (watch(isWaitingPersonCreation).state) ...[
              verticalSpace(),
              const ProgressBar()
            ],
            verticalSpace(),
            Row(children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: _isValid(watch)
                    ? () => context.read(_viewModel).add(context)
                    : () {},
                child: Text(
                    watch(editPersonUuid).state != null
                        ? Strings.savePerson
                        : Strings.createPerson,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ))
            ])
          ],
        ),
      ),
    );
  }

  bool _isValid(ScopedReader watch) {
    return watch(personCreatorNameTextController).text.isNotEmpty &&
        watch(personCreatorDescriptionTextController).text.isNotEmpty &&
        watch(personCreatorGame).state != null;
  }
}
