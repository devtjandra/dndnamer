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
    return Scaffold(
        body: Container(
      child: Column(
        children: items(watch),
      ),
    ));
  }

  List<Widget> items(ScopedReader watch) {
    final items = watch(_nameGeneratorList.state);
    return items.map((e) => Text(e)).toList();
  }
}
