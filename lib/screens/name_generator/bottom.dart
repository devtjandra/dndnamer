import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:dndnamer/screens/name_generator/name_generator.dart';
import 'package:flutter_riverpod/all.dart';

class Bottom extends ConsumerWidget {
  const Bottom();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.white,
      child: Wrap(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: OutlineButton(
                        onPressed: () => context.read(panelController).open(),
                        child: Text(watch(race).state)),
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
        onPressed: () => context.read(nameGeneratorList).restart(),
        child: Text("Go"),
      )),
      horizontalSpace(),
      ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, Routes.favouritesList),
          child: const Icon(Icons.favorite))
    ]);
  }
}
