import 'package:dndnamer/config/notifiers.dart';
import 'package:dndnamer/config/types.dart';
import 'package:dndnamer/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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

    return Scaffold(
        body: Container(
            child: watch(_isEmpty)
                ? Text("No names for you!")
                : ListView.builder(
                    itemBuilder: (context, index) => NameItem(list[index]),
                    itemCount: list.length)));
  }
}

class NameItem extends StatelessWidget {
  final String value;

  NameItem(this.value);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Text(value),
      ),
    );
  }
}
