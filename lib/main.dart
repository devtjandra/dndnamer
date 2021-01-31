import 'package:dndnamer/app/login/view/login.dart';
import 'package:dndnamer/app/name_generator/view/name_generator.dart';
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
          Routes.nameGenerator: (_) => NameGenerator()
        },
        theme: ThemeData(
            fontFamily: "Montserrat",
            colorScheme: const ColorScheme.light(primary: Color(0xffbf283a))),
        initialRoute: Routes.splash);
  }
}
