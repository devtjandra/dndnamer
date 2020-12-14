import 'package:flutter_riverpod/all.dart';

class NameGeneratorListNotifier extends StateNotifier<List<String>> {
  NameGeneratorListNotifier(): super(List());

  void clear() {
    state = List();
  }

  void addItems(List<String> items) {
    state.addAll(items);
  }
}