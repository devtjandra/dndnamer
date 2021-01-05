import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class FavouritesList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Saved"),
      ),
      body: Container(
        child: Text("Favourites list"),
      ),
    );
  }
}
