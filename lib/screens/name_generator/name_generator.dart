import 'package:dndnamer/config/notifiers.dart';
import 'package:dndnamer/config/types.dart';
import 'package:dndnamer/screens/name_generator/bottom.dart';
import 'package:dndnamer/screens/name_generator/name_item.dart';
import 'package:dndnamer/screens/name_generator/race_list.dart';
import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final isWaiting = StateProvider<bool>((ref) => false);
final race = StateProvider<String>((ref) => races[0]);

final nameGeneratorList = StateNotifierProvider<NameGeneratorListNotifier>(
    (ref) => NameGeneratorListNotifier(ref));
final panelController = Provider<PanelController>((ref) => PanelController());

final _isEmpty =
    Provider<bool>((ref) => ref.watch(nameGeneratorList.state).isEmpty);

class NameGenerator extends ConsumerWidget {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final list = watch(nameGeneratorList.state);

    _controller.addListener(() {
      if (_controller.position.atEdge && _controller.position.pixels != 0) {
        context.read(nameGeneratorList).getItems();
      }
    });

    return SlidingUpPanel(
        minHeight: 0.0,
        maxHeight: 300.0,
        panel: const RaceList(),
        controller: watch(panelController),
        body: SafeArea(
            child: Scaffold(
          body: Column(children: [
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        width: double.infinity,
                        height: 170,
                        color: Colors.black87),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const Text(
                        "DND NAMER",
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ),
                  if (watch(_isEmpty)) _empty() else _list(list),
                  shadow(),
                  if (watch(isWaiting).state) _loading()
                ],
              ),
            ),
            const Bottom()
          ]),
        )));
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

  Widget _list(List<String> items) {
    return Padding(
        padding: const EdgeInsets.only(top: 65),
        child: ListView.builder(
            controller: _controller,
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, bottom: 24.0, top: 4.0),
            itemBuilder: (context, index) => NameItem(items[index]),
            itemCount: items.length));
  }
}
