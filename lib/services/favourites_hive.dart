import 'dart:io';

import 'package:dndnamer/models/person.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class FavouritesHive {
  static void init() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive
      ..init(dir.path)
      ..registerAdapter(PersonAdapter());
  }

  static void save(String name, String description) {
    Hive.openBox('people').then((value) {
      if (!value.isOpen) return;
      Hive.box('people').add(Person(name, description));
    });
  }

  static List<Person> people() {
    return Hive.box('people').values;
  }
}
