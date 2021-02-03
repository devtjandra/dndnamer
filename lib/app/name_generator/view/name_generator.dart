import 'package:dndnamer/app/name_generator/logic/name_generator_view_model.dart';
import 'package:dndnamer/app/name_generator/view/bottom.dart';
import 'package:dndnamer/app/name_generator/view/name_item.dart';
import 'package:dndnamer/app/name_generator/view/race_list.dart';
import 'package:dndnamer/app/person_creator/view/person_creator.dart';
import 'package:dndnamer/config/types.dart';
import 'package:dndnamer/values/routes.dart';
import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final nameGeneratorViewModel = StateNotifierProvider<NameGeneratorViewModel>(
    (ref) => NameGeneratorViewModel(ref));

final nameGeneratorPanelController =
    Provider<PanelController>((ref) => PanelController());
final isWaitingNameGeneration = StateProvider<bool>((ref) => false);
final isNameGeneratorEmpty =
    Provider<bool>((ref) => ref.watch(nameGeneratorViewModel.state).isEmpty);
final nameGeneratorRace = StateProvider<String>((ref) => races[0]);

class NameGenerator extends ConsumerWidget {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final list = watch(nameGeneratorViewModel.state);

    _controller.addListener(() {
      if (_controller.position.atEdge && _controller.position.pixels != 0) {
        context.read(nameGeneratorViewModel).getItems();
      }
    });

    return SafeArea(
      child: Column(children: [
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                    width: double.infinity, height: 170, color: Colors.black87),
              ),
              if (watch(isNameGeneratorEmpty))
                _empty()
              else
                ListView.builder(
                    controller: _controller,
                    itemCount: list.length,
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 24.0, top: 4.0),
                    itemBuilder: (context, index) => NameItem(
                          list[index],
                          onSave: () {
                            context.read(editPersonUuid).state = null;
                            context.read(personCreatorGame).state = null;
                            context.read(personCreatorImportance).state = 0;
                            context.read(personCreatorNameTextController).text =
                                list[index];
                            context
                                .read(personCreatorDescriptionTextController)
                                .text = "";

                            Navigator.pushNamed(context, Routes.personCreator);
                          },
                        )),
              shadow(),
              if (watch(isWaitingNameGeneration).state) _loading(),
              SlidingUpPanel(
                  minHeight: 0.0,
                  maxHeight: 350.0,
                  panel: const RaceList(),
                  controller: watch(nameGeneratorPanelController),
                  body: Container())
            ],
          ),
        ),
        const Bottom()
      ]),
    );
  }

  Widget _loading() {
    return const Padding(
      padding: EdgeInsets.all(25.0),
      child: ProgressBar(),
    );
  }

  Widget _empty() {
    return Container();
  }
}
