import 'package:dndnamer/screens/favourites_list/favourites_list.dart';
import 'package:dndnamer/screens/name_generator/name_generator.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DnD Namer',
        routes: {
          Routes.nameGenerator: (_) => NameGenerator(),
          Routes.favouritesList: (_) => FavouritesList()
        },
        theme: ThemeData(
            fontFamily: "Montserrat",
            colorScheme: const ColorScheme.light(primary: Color(0xffbf283a))),
        initialRoute: Routes.nameGenerator);
  }
}
