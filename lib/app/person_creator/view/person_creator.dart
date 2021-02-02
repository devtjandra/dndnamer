import 'package:dndnamer/app/person_creator/logic/person_creator_view_model.dart';
import 'package:dndnamer/app/person_creator/view/game_selector_list.dart';
import 'package:dndnamer/config/types.dart';
import 'package:dndnamer/models/game.dart';
import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final _viewModel =
    Provider<PersonCreatorViewModel>((ref) => PersonCreatorViewModel(ref));

final personCreatorPanelController =
    Provider<PanelController>((ref) => PanelController());
final personCreatorNameTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final personCreatorDescriptionTextController =
    Provider<TextEditingController>((ref) => TextEditingController());
final personCreatorImportance = StateProvider<int>((ref) => 0);
final personCreatorGame = StateProvider<Game>((ref) => null);
final isWaitingPersonCreation = StateProvider<bool>((ref) => false);

class PersonCreatorArguments {
  final String name;

  PersonCreatorArguments({@required this.name});
}

class PersonCreator extends ConsumerWidget {
  bool _initialNameSet = false;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    if (!_initialNameSet) {
      _initialNameSet = true;
      final args = ModalRoute.of(context).settings.arguments;

      if (args != null) {
        final personCreatorArgs = args as PersonCreatorArguments;
        watch(personCreatorNameTextController).text = personCreatorArgs.name;
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text(Strings.personCreatorTitle),
        ),
        body: Stack(children: [
          Container(
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
                        child: Text(watch(personCreatorGame).state?.title ??
                            Strings.emptyGame),
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
                    maxLines: 5,
                    decoration: const InputDecoration.collapsed(
                        hintText: Strings.description,
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  Slider(
                    value: watch(personCreatorImportance).state.toDouble(),
                    max: 3,
                    divisions: 3,
                    label: importance[watch(personCreatorImportance).state],
                    onChanged: (double value) => context
                        .read(personCreatorImportance)
                        .state = value.toInt(),
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
                      child: const Text(Strings.createPerson),
                    ))
                  ])
                ],
              ),
            ),
          ),
          SlidingUpPanel(
              minHeight: 0.0,
              maxHeight: 350.0,
              panel: const GameSelectorList(),
              controller: watch(personCreatorPanelController),
              body: Container())
        ]));
  }

  bool _isValid(ScopedReader watch) {
    return watch(personCreatorNameTextController).text.isNotEmpty &&
        watch(personCreatorDescriptionTextController).text.isNotEmpty &&
        watch(personCreatorGame).state != null;
  }
}
