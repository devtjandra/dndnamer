import 'package:dndnamer/app/name_generator/logic/home_drawer_view_model.dart';
import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter_riverpod/all.dart';

final _viewModel =
    Provider<HomeDrawerViewModel>((ref) => HomeDrawerViewModel(ref));

final isWaitingLogout = StateProvider<bool>((ref) => false);

class HomeDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(children: [
      const DrawerHeader(
        // decoration: BoxDecoration(color: Colors.black87),
        child: Text(
          "Welcome, Devina!",
          // style: TextStyle(color: Colors.white),
        ),
      ),
      const ListTile(title: Text(Strings.home)),
      const ListTile(
        title: Text(Strings.games),
      ),
      ListTile(
        title: const Text(Strings.logOut),
        onTap: () => context.read(_viewModel).signOut(context),
      ),
      if (watch(isWaitingLogout).state) const ProgressBar()
    ]);
  }
}
