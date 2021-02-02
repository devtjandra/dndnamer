import 'package:dndnamer/app/name_generator/view/name_generator.dart';
import 'package:dndnamer/config/types.dart';
import 'package:dndnamer/widgets/horizontal_line.dart';
import 'package:dndnamer/widgets/selector_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class RaceList extends ConsumerWidget {
  const RaceList();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(12.0),
              child: const Text(
                "SELECT RACE",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 12.0),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 4.0),
              child: IconButton(
                  icon: const Icon(Icons.close),
                  color: Colors.black38,
                  onPressed: () =>
                      context.read(nameGeneratorPanelController).close()),
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8.0, bottom: 12.0, top: 4.0),
              itemBuilder: (c, index) => _raceWidget(races[index], context),
              itemCount: races.length),
        )
      ],
    ));
  }

  void _selectRace(String value, BuildContext context) {
    context.read(nameGeneratorPanelController).close();

    if (context.read(nameGeneratorRace).state != value) {
      context.read(nameGeneratorRace).state = value;
      context.read(nameGeneratorViewModel).restart();
    }
  }

  Widget _raceWidget(String value, BuildContext context) {
    return SelectorItem(text: value, onTap: () => _selectRace(value, context));
  }
}
