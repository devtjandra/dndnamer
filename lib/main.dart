import 'package:dndnamer/app/game_creator/view/game_creator.dart';
import 'package:dndnamer/app/game_details/view/game_details.dart';
import 'package:dndnamer/app/home/view/home.dart';
import 'package:dndnamer/app/login/view/login.dart';
import 'package:dndnamer/app/person_creator/view/person_creator.dart';
import 'package:dndnamer/app/person_details/view/person_details.dart';
import 'package:dndnamer/app/splash/view/splash.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DnD Namer',
        routes: {
          Routes.splash: (_) => Splash(),
          Routes.login: (_) => Login(),
          Routes.home: (_) => Home(),
          Routes.gameCreator: (_) => GameCreator(),
          Routes.personCreator: (_) => PersonCreator(),
          Routes.gameDetails: (_) => GameDetails(),
          Routes.personDetails: (_) => PersonDetails()
        },
        theme: ThemeData(
            fontFamily: "Montserrat",
            colorScheme: const ColorScheme.dark(
                primary: Color(0xffbf283a), secondary: Color(0xffbf283a))),
        initialRoute: Routes.splash);
  }
}
