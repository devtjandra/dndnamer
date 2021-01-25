import 'package:dndnamer/models/person.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class FavouritesListNotifier extends StateNotifier<List<Person>> {
  final ProviderReference ref;

  FavouritesListNotifier(this.ref) : super([]) {
    _init();
  }

  Future<void> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive
      ..init(dir.path)
      ..registerAdapter(PersonAdapter());
    refreshPeople();
  }

  Future<void> save(String name, String description) async {
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

  Future<void> delete(String name) async {
    final hive = await Hive.openBox('people');
    if (!hive.isOpen) return;
    await Hive.box('people').delete(name);
    await Hive.close();
    refreshPeople();
  }

  Future<void> refreshPeople() async {
    final hive = await Hive.openBox('people');
    if (!hive.isOpen) return;

    final values = Hive.box('people').values;
    final peopleValues = values.map((e) => e as Person).toList();
    state = peopleValues;

    await Hive.close();
  }
}
