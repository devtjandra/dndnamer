import 'package:dndnamer/screens/name_generator/name_generator.dart';
import 'package:dndnamer/services/api_client.dart';
import 'package:dndnamer/models/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

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
    var list = state;
    list.addAll(items);
    state = list;
  }

  void getItems() async {
    if (ref.read(isWaiting).state) return;

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

class FavouritesListNotifier extends StateNotifier<List<Person>> {
  final ProviderReference ref;

  FavouritesListNotifier(this.ref) : super(List()) {
    _init();
  }

  void _init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive
      ..init(dir.path)
      ..registerAdapter(PersonAdapter());
    refreshPeople();
  }

  void save(String name, String description) async {
    final hive = await Hive.openBox('people');
    if (!hive.isOpen) return;
    await Hive.box('people').put(name, Person(name, description));
    await Hive.close();
    refreshPeople();
  }

  Future<bool> doesPersonExist(String name) async {
    final hive = await Hive.openBox('people');
    if (!hive.isOpen) return false;
    final person = await Hive.box('people').get(name);
    await Hive.close();
    return person != null;
  }

  void delete(String name) async {
    final hive = await Hive.openBox('people');
    if (!hive.isOpen) return;
    await Hive.box('people').delete(name);
    await Hive.close();
    refreshPeople();
  }

  void refreshPeople() async {
    final hive = await Hive.openBox('people');
    if (!hive.isOpen) return;

    final values = Hive.box('people').values;
    List<Person> newPeople = List();
    values.forEach((element) => newPeople.add(element));
    state = newPeople;

    await Hive.close();
  }
}


