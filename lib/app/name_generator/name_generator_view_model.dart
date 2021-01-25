import 'package:dndnamer/app/name_generator/name_generator_client.dart';
import 'package:dndnamer/app/name_generator/name_generator.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter/material.dart';

class NameGeneratorViewModel extends StateNotifier<List<String>> {
  final ProviderReference ref;
  final client = NameGeneratorClient();

  NameGeneratorViewModel(this.ref) : super([]) {
    Future.delayed(Duration.zero, () => getItems());
  }

  void restart() {
    state = [];
    getItems();
  }

  void addItems(List<String> items) {
    final list = state;
    list.addAll(items);
    state = list;
  }

  Future<void> getItems() async {
    if (ref.read(isWaitingNameGeneration).state) return;

    ref.read(isWaitingNameGeneration).state = true;
    final raceQuery = ref.watch(nameGeneratorRace).state;

    client.getNames(raceQuery).then((value) {
      ref.read(isWaitingNameGeneration).state = false;
      addItems(value);
    }).catchError((error) {
      ref.read(isWaitingNameGeneration).state = false;
      debugPrint("Error $error");
    });
  }
}
