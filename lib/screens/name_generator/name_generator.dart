import 'package:dndnamer/config/notifiers.dart';
import 'package:dndnamer/config/types.dart';
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
            watch(isWaiting).state
                ? _loading()
                : (watch(_isEmpty) ? _empty() : _list(list)),
            shadow()
          ],
        ),
      ),
      _bottom(context)
    ])));
  }

  Widget _loading() {
    return Container(
      alignment: Alignment.center,
      child: Text("Loading"),
    );
  }

  Widget _empty() {
    return Text("No names for you!");
  }

  Widget _list(List<String> items) {
    return ListView.builder(
        controller: _controller,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        itemBuilder: (context, index) => NameItem(items[index]),
        itemCount: items.length);
  }

  Widget _bottom(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Wrap(
        children: [
          Column(
            children: [_raceButton(context), _buttonRow(context)],
          )
        ],
      ),
    );
  }

  Widget _raceButton(BuildContext context) {
    return OutlineButton(
        onPressed: () => context.read(_nameGeneratorList).restart(),
        child: Text("Go"));
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

class NameItem extends StatelessWidget {
  final String value;

  NameItem(this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
        child: Text(value),
      ),
    );
  }
}
