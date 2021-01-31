import 'package:dndnamer/app/splash/logic/splash_view_model.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final _viewModel = Provider<SplashViewModel>((ref) => SplashViewModel(ref));

final isWaitingSplash = StateProvider<bool>((ref) => false);

class Splash extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    watch(_viewModel).initialise(context);

    return Scaffold(
      body: Column(
        children: const [
          Text(Strings.title, style: Styles.titleText),
        ],
      ),
    );
  }
}
