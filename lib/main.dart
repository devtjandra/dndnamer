import 'package:dndnamer/screens/name_generator/name_generator.dart';
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
        theme: ThemeData(fontFamily: "Montserrat"),
        home: NameGenerator());
  }
}
