import 'package:dndnamer/config/notifiers.dart';
import 'package:dndnamer/config/types.dart';
import 'package:dndnamer/screens/name_generator/name_item.dart';
import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:dndnamer/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final isWaiting = StateProvider<bool>((ref) => false);
final race = StateProvider<String>((ref) => races[0]);

final _nameGeneratorList = StateNotifierProvider<NameGeneratorListNotifier>(
    (ref) => NameGeneratorListNotifier(ref));
final _isEmpty =
    Provider<bool>((ref) => ref.watch(_nameGeneratorList.state).isEmpty);

class NameGenerator extends ConsumerWidget {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final list = watch(_nameGeneratorList.state);

    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (_controller.position.pixels != 0)
          context.read(_nameGeneratorList).getItems();
      }
    });

    return SafeArea(
        child: Scaffold(
            body: Column(children: [
      Expanded(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  width: double.infinity, height: 170, color: Colors.black87),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  "DND NAMER FOR JOSH <3",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
            watch(_isEmpty) ? _empty() : _list(list),
            shadow(),
            if (watch(isWaiting).state) _loading()
          ],
        ),
      ),
      Bottom()
    ])));
  }

  Widget _loading() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ProgressBar(),
    );
  }

  Widget _empty() {
    return Text("No names for you!");
  }

  Widget _list(List<String> items) {
    return Padding(
        padding: EdgeInsets.only(top: 50),
        child: ListView.builder(
            controller: _controller,
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            itemBuilder: (context, index) => NameItem(items[index]),
            itemCount: items.length));
  }
}

class Bottom extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Container(
      color: Colors.white,
      child: Wrap(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: OutlineButton(
                        onPressed: () =>
                            context.read(_nameGeneratorList).restart(),
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
        onPressed: () => context.read(_nameGeneratorList).restart(),
        child: Text("Go"),
      )),
      horizontalSpace(),
      ElevatedButton(
          onPressed: () => context.read(_nameGeneratorList).restart(),
          child: Icon(Icons.favorite))
    ]);
  }
}
