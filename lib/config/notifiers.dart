import 'package:dndnamer/screens/name_generator/name_generator.dart';
import 'package:dndnamer/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class NameGeneratorListNotifier extends StateNotifier<List<String>> {
  final ProviderReference ref;

  NameGeneratorListNotifier(this.ref) : super(List()) {
    Future.delayed(Duration.zero, () => getItems());
  }

  void restart() {
    state = List();
    getItems();
  }

  void addItems(List<String> items) {
    state.addAll(items);
  }

  void getItems() async {
    ref.read(isWaiting).state = true;
    final raceQuery = ref.watch(race).state;
    ApiClient().getNames(raceQuery).then((value) {
      ref.read(isWaiting).state = false;
      addItems(value);
    }).catchError((error) {
      ref.read(isWaiting).state = false;
      debugPrint("Error $error");
    });
  }
}
