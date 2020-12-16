import 'package:dndnamer/config/notifiers.dart';
import 'package:dndnamer/config/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final isWaiting = StateProvider<bool>((ref) => false);
final race = StateProvider<String>((ref) => races[0]);

final _nameGeneratorList = StateNotifierProvider<NameGeneratorListNotifier>(
    (ref) => NameGeneratorListNotifier(ref));
final _isEmpty =
    Provider<bool>((ref) => ref.watch(_nameGeneratorList.state).isEmpty);

class NameGenerator extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final list = watch(_nameGeneratorList.state);

    return SafeArea(
        child: Scaffold(
            persistentFooterButtons: [_header(context)],
            body: Container(
                child: watch(isWaiting).state
                    ? _loading()
                    : (watch(_isEmpty) ? _empty() : _list(list)))));
  }

  Widget _loading() {
    return Text("Loading");
  }

  Widget _empty() {
    return Text("No names for you!");
  }

  Widget _list(List<String> items) {
    return ListView.builder(
        itemBuilder: (context, index) => NameItem(items[index]),
        itemCount: items.length);
  }

  Widget _header(BuildContext context) {
    return ElevatedButton(
        onPressed: () => context.read(_nameGeneratorList).restart(),
        child: Text("Generate!"));
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
