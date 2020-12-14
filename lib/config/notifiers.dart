import 'package:riverpod/all.dart';

class NameListNotifier extends StateNotifier<List<String>> {
  NameListNotifier(): super(List());

  void clear() {
    state = List();
  }

  void addItems(List<String> items) {
    state.addAll(items);
  }
}