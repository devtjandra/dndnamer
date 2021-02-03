import 'package:dndnamer/app/name_generator/view/name_generator.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class Bottom extends ConsumerWidget {
  const Bottom();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      // color: Colo,
      child: Wrap(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: OutlineButton(
                        onPressed: () =>
                            context.read(nameGeneratorPanelController).open(),
                        child: Text(watch(nameGeneratorRace).state)),
                  )
                ],
              ),
              _buttonRow(context)
            ],
          )
        ],
      ),
    );
  }

  Widget _buttonRow(BuildContext context) {
    return Row(children: [
      Expanded(
          child: ElevatedButton(
        onPressed: () => context.read(nameGeneratorViewModel).restart(),
        child: const Text(Strings.nameGeneratorButton,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      )),
    ]);
  }
}
