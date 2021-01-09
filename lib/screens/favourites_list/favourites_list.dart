import 'package:dndnamer/screens/favourites_list/person_item.dart';
import 'package:dndnamer/services/dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class FavouritesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Saved"),
      ),
      body: Container(
        child: _list(watch),
      ),
    ));
  }

  Widget _list(ScopedReader watch) {
    var items = watch(favouritesList.state);
    return Padding(
        padding: const EdgeInsets.only(top: 65),
        child: items != null && items.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, bottom: 24.0, top: 4.0),
                itemBuilder: (context, index) =>
                    PersonItem(items[index]),
                itemCount: items.length)
            : Container());
  }
}
